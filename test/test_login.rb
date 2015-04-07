require 'test_helper'

class LoginTest < Minitest::Test

  def setup
    @user = ZimbraPreAuthRouter::User.new("pbruna@example.com", "1234567891011121314")
  end
  
  
  def test_valid_auth_should_have_zm_auth_token_cookie
    login = ZimbraPreAuthRouter::Login.new(@user)
    assert(login.zm_auth_token, "Failure message.")
    assert(login.valid?, "Failure message.")
  end
  
  def test_invalid_login_should_return_false
    @user.password = "929229"
    login = ZimbraPreAuthRouter::Login.new(@user)
    assert(!login.valid?, "Failure message.")
  end
  
end