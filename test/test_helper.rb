ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/reporters' # requires the gem
require 'rack/test'

require File.expand_path '../../app.rb', __FILE__

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new # spec-like progress

ZimbraPreAuthRouter::Config.domain="example.com"
ZimbraPreAuthRouter::Config.migrated_users_file="./test/fixtures/users.yml"

# You should change this
ZimbraPreAuthRouter::Config.old_backend_url = "http://www.example.com"
ZimbraPreAuthRouter::Config.new_backend_url = "http://mail.zbox.cl"
