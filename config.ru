require_relative 'app.rb'

####### Configurarion Options ############################

# This is the domain you are migrating
# Like "example.com"
ZimbraPreAuthRouter::Config.domain = ENV['domain']

# YAM file with absolute path where your keep the list
# of migrated mailboxes.
ZimbraPreAuthRouter::Config.migrated_users_file = ENV['users_file']

# Origin Webmail URL 
# Like "http://mail.domain.com"
ZimbraPreAuthRouter::Config.old_backend_url = ENV['old_backend']

# New Destination Webmail URL
# Like "http://mail.domain.com"
ZimbraPreAuthRouter::Config.new_backend_url = ENV['new_backend']

# Domain Pre Auth Key on Origin Platform
# You can get the key running $ zmprov gd domain.com zimbraPreAuthKey
# Read here how to setup it https://wiki.zimbra.com/wiki/Preauth 
ZimbraPreAuthRouter::Config.old_preauth_key = ENV['old_preauth_key']

# Domain Pre Auth Key on Destination Platform
# You can get the key running $ zmprov gd domain.com zimbraPreAuthKey
# Read here how to setup it https://wiki.zimbra.com/wiki/Preauth
ZimbraPreAuthRouter::Config.new_preauth_key = ENV['new_preauth_key']

####### END CONFIGURATION ############################

###### DONT TOUCH FROM HERE ######################

run App