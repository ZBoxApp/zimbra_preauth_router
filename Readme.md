# Zimbra Preauth Router

A web Authentication portal for [Zimbra Collaboration](http://www.zimbra.com) with a twist, and the twist is: **works for 0 downtime migrations**.

Zimbra Preauth Router (ZPR) lets you login users in 2 diferent Zimbra platforms from a single URL portal, only using a YAML map file.

#### Why only 2 diferrent Zimbra?
Because is all that we need for the moment. But could be easily expanded.

#### Use cases

* A hibrid Network and Open Source setup of Zimbra.
* Diferent Zimbras, but you need to have one login portal
* Migrations, this is why we built it.

At [ZBox Mail](https://www.zboxapp.com) we are faced with migrations from production Zimbra servers to our cloud platform. Some times the source servers are small enough that you can bring down the service for a couple of hours, migrate all the mailboxes and start again in the new home.

But _luckily_ for us we are currently migrating bigger servers thant small ones. For big we are talking over 1,000 mailboxes and Terabytes of mail data. And you can not migrate this in a couple of hours.

So we came with this procedure to do a 0 downtime migration:

1. Setup a split domain between the 2 platforms.
3. the company must announce that a migration is in place, and for as long the migration take place, only the use of Webmail is allowed
3. Migrate group of mailboxes.
4. Celebrate

The big win is in the exclusive use of the the Webmail, this way you can use Zimbra Preauth Router an let it redirect the user to the old or new platform.

The way the Zimbra Preauth Router works is by replacing the standard Zimbra Login Page, the procedure is as follows:

1. The user authenticate against ZPR,
2. ZPR reads look a DB file for an entry for this user, what would mean that is a migrated user.
3. If it is a migrated used, ZPR redirects to the new platform, if not, to the current platform.

This way the users doesn't have to learn a new URL and the migration process is transparent for them.

For ZPR to works you need to configure Preauth Keys for the Domains, as explained in here.

All the information on how to install and use ZPR can be found here:

As always, all ideas are welcome.

## Installation and Setup

ZPR is configured thorugh Enviroment Variables.
You have to ways to use this:

### Clone and setup yourself

For this to work you must have Ruby > 2 installed.

#### 1. Clone the repo

#### 2. Install de dependencies


#### 3. Launch the aplications

## Usage

```
docker run -v /Users/pbruna/tmp:/opt/zimbra_preauth_router -e "DOMAIN=ind.cl" -e "OLD_BACKEND=http://www.indmail.cl" -e "NEW_BACKEND=http://mail.zbox.cl" -e "OLD_PREAUTH_KEY=e08f44cb1aba93cc6eb689cf264920e00ab770a398f7bb8c9c98ebeeeba8577c" -e "LOGO=http://www.ind.cl/wp-content/themes/mindep-2014/images/logo.png" -e "USERS_FILE=/opt/zimbra_preauth_router/users.yml" -p 8080:80 pbruna/zimbra_preauth_router:0.1.8
```
## Contributing

1. Fork it ( https://github.com/[my-github-username]/zimbra_proxy_spy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request