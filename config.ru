require_relative 'app.rb'

####### Configurarion Options ############################


# Logo image to show. Should be 250px X 70px
# Like "http://img.exmaple.com/img.png"
ZimbraPreAuthRouter::Config.logo_img = ENV['LOGO']

# This is the domain you are migrating
# Like "example.com"
ZimbraPreAuthRouter::Config.domain = ENV['DOMAIN']

# YAM file with absolute path where your keep the list
# of migrated mailboxes.
ZimbraPreAuthRouter::Config.migrated_users_file = ENV['USERS_FILE']

# Origin Webmail URL
# Like "http://mail.domain.com"
ZimbraPreAuthRouter::Config.old_backend_url = ENV['OLD_BACKEND']

# New Destination Webmail URL
# Like "http://mail.domain.com"
ZimbraPreAuthRouter::Config.new_backend_url = ENV['NEW_BACKEND']

# Domain Pre Auth Key on Origin Platform
# You can get the key running $ zmprov gd domain.com zimbraPreAuthKey
# Read here how to setup it https://wiki.zimbra.com/wiki/Preauth
ZimbraPreAuthRouter::Config.old_preauth_key = ENV['OLD_PREAUTH_KEY']

# Domain Pre Auth Key on Destination Platform
# You can get the key running $ zmprov gd domain.com zimbraPreAuthKey
# Read here how to setup it https://wiki.zimbra.com/wiki/Preauth
ZimbraPreAuthRouter::Config.new_preauth_key = ENV['NEW_PREAUTH_KEY']

####### END CONFIGURATION ############################

###### DONT TOUCH FROM HERE ######################

puts "------------------------------------------------"
puts "ZimbraPreAuthRouter v. #{ZimbraPreAuthRouter::VERSION}"
puts "Starting server with the following configuration"
puts "Domain: #{ZimbraPreAuthRouter::Config.domain}"
puts "Logo img: #{ZimbraPreAuthRouter::Config.logo_img}"
puts "Users File: #{ZimbraPreAuthRouter::Config.migrated_users_file}"
puts "Old BackendURL: #{ZimbraPreAuthRouter::Config.old_backend_url}"
puts "New BackendURL: #{ZimbraPreAuthRouter::Config.new_backend_url}"
puts "Old Preauth Key: #{ZimbraPreAuthRouter::Config.old_preauth_key}"
puts "New Preauth Key: #{ZimbraPreAuthRouter::Config.new_preauth_key}"
puts "------------------------------------------------\n"

run App
