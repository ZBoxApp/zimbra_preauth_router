# Zimbra Preauth Router

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'zimbra_proxy_spy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zimbra_proxy_spy

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