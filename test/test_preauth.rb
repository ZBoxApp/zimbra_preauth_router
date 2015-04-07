require 'test_helper'
require 'pp'

class PreauthTest < Minitest::Test
  
  include Rack::Test::Methods
  
  def app
    App
  end
  
  def test_login_form
    get '/'
    assert(last_response.ok?, "Failure message.")
  end
  
  
  def test_post_bad_login_info
    post "/login", {username: "pbruna", password: "kdkadkdakdak"}
    assert(last_response.ok?, "Failure message.")
    pp "#{last_response.body}"
    assert last_response.body.include? "incorrecta"
  end
  
end