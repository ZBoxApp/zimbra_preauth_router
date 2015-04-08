# Zimbra Preauth Router

A web Authentication portal for [Zimbra Collaboration](http://www.zimbra.com) with a twist, and the twist is: **works for 0 downtime migrations**.

Zimbra Preauth Router ( ZPR from now on) lets you login users in 2 diferent Zimbra platforms from a single URL portal, only using a `YAML` db file.

**Why only 2 diferent Zimbra Platforms?**
Because is all that we need for the moment. But could be easily expanded.

#### Use cases

* A hibrid Network and Open Source setup of Zimbra.
* Diferent Zimbras, but you need to have one login portal
* Migrations, this is why we built it.

## Zimbra Requirements
For this to work you need to have `Preauth Keys` for the Domains in every Zimbra Platform.

To generate a key for the `example.com` domain you have to run the next command in the Zimbra server, as the zimbra user:

```
[zimbra@old_backend]$ zmprov gdpak example.com
preAuthKey: 9b34da63e5c1cba4cf7eb8262bacb18f712f6abafb02cf670234cb9bca63cb31

```

You can check the Preauth Key of a domain with:
```
[zimbra@old_backend]$ zmprov gd example.com zimbraPreAuthKey
 # name example.com
zimbraPreAuthKey: 9b34da63e5c1cba4cf7eb8262bacb18f712f6abafb02cf670234cb9bca63cb31

```

Check the Zimbra Wiki for more information about `Preauth Keys`: [https://wiki.zimbra.com/wiki/Preauth#Sample_Ruby_code_for_computing_the_preauth_value](https://wiki.zimbra.com/wiki/Preauth#Sample_Ruby_code_for_computing_the_preauth_value)

## Configuration 
ZPR is configured using `Enviroment Variables`, following the directions by [The Twelve-Factor App](http://12factor.net), the variables and their uses are as follows:

* `LOGO`, the logo image to be shown on the login portal. Should be 250 X 70px
* `DOMAIN`, the email domain, used mostly for when the user enter only the local part in the login form
* `USERS_FILE`, complete path to the YAML DB File where we enter the email address of the users located on the `NEW_BACKEND`
* `OLD_BACKEND`, the URL of the Source Zimbra like: `http://mail.example.com`
* `NEW_BACKEND`, the URL of the Destination Zimbra like: `http://new-mail.example.com`
* `OLD_PREAUTH_KEY`, the Preauth Key of the `DOMAIN` at `OLD_BACKEND`
* `NEW_PREAUTH_KEY`, the Preauth Key of the `DOMAIN` at `NEW_BACKEND`

### A note about the YAML file
Its important to notice that the file must end in `.yml` and the format of the content should be:

```yaml
pbruna@example.com: "7302d6d0-c024-0132-207e-482a1423458f"
watson@example.com: "9313df60-c024-0132-207e-482a1423458f"
```

The first field is the email address, and the second is the value of `zimbraId`. You can get the `zimbraId` value with:

```bash
$ zmprov ga pbruna@example.com zimbraId
 # name pbruna@example.com
zimbraId: 7302d6d0-c024-0132-207e-482a1423458f
```

## Install and Run
You have to ways to use `ZPR`: Manual Setup and Docker Img.
We recomend the Docker Img.

### The Docker Way
This is by far the easy way.

**1. Have a docker setup working**
You should have a Linux machine with docker installed.

**2. Pull the image from docker**
```bash
$ docker pull pbruna/zimbra_preauth_router
```

**3. Launch and Profit**
A couple of notes on the parameters:

* `-p 80:80`: listen on port 80
* `-v /opt/zimbra_preauth_router:/opt/zimbra_preauth_router`: share the local `/opt/zimbra_preauth_route` folder with the docker container, here you will create the `users.yml` file.
* `-e *`: all of this are ENV variables to pass to Zimbra Preauth Router.

```bash
$ docker run -p 80:80 -v /opt/zimbra_preauth_router:/opt/zimbra_preauth_router \
  -e "DOMAIN=ind.cl" \
  -e "OLD_BACKEND=http://mail.example.com" \
  -e "NEW_BACKEND=http://new-mail.example.com" \
  -e "OLD_PREAUTH_KEY=9b34da63e5c1cba4cf7eb8262bacb18f712f6abafb02cf670234cb9bca63cb31" \
  -e "NEW_PREAUTH_KEY="9b34da63e5c1cba4cf7eb8262bacb18f712f6abafb02cf670234cb9bca63cb31" \
  -e "LOGO=http://www.ind.cl/wp-content/themes/mindep-2014/images/logo.png" \
  -e "USERS_FILE=/opt/zimbra_preauth_router/users.yml" \
  pbruna/zimbra_preauth_router
```

That command will lunch the container on the `foreground` and you can connect to it now ponting to `http://HOST_IP_ADDR/`.
You can launch the container in the background adding the `-d` param to the command, like:

```bash
$ docker run -d -p 80:80 -v /opt/zimbra_preauth_router:/opt/zimbra_preauth_router \
......

 # check the status:
$ docker ps
```

### Manual Setup
For this to work you must have `Ruby > 2` installed.

**1. Clone the repo**
```bash
$ git clone https://github.com/pbruna/zimbra_preauth_router.git
```

**2. Install dependencies**
```bash
$ cd zimbra_preauth_router
$ bundle install
```

**3. Run the server**
```bash
$ DOMAIN="example.com" USERS_FILE="/tmp/file.yaml" OLD_BACKEND="http://mail.example.com" \
  NEW_BACKEND="http://new-mail.example.com"  \
  OLD_PREAUTH_KEY="9b34da63e5c1cba4cf7eb8262bacb18f712f6abafb02cf670234cb9bca63cb31" \
  NEW_PREAUTH_KEY="9b34da63e5c1cba4cf7eb8262bacb18f712f6abafb02cf670234cb9bca63cb31" \
  bundle exec rackup -p 8080
```

You should see something like:

```bash
------------------------------------------------
Starting server with the following configuration
Domain: example.com
Logo img: logo.png
Users File: /tmp/file.yaml
Old BackendURL: http://mail.example.com
New BackendURL: http://new-mail.example.com
Old Preauth Key: 9b34da63e5c1cba4cf7eb8262bacb18f712f6abafb02cf670234cb9bca63cb31
New Preauth Key: 9b34da63e5c1cba4cf7eb8262bacb18f712f6abafb02cf670234cb9bca63cb31
------------------------------------------------
[2015-04-08 10:59:05] INFO  WEBrick 1.3.1
[2015-04-08 10:59:05] INFO  ruby 2.1.1 (2014-02-24) [x86_64-darwin13.0]
[2015-04-08 10:59:05] INFO  WEBrick::HTTPServer#start: pid=18655 port=8080
```

And now you can point your browser to the IP address at port 8080.


## Contributing

1. Fork it ( https://github.com/pbruna/zimbra_preauth_router/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request