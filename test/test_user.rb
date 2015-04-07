require 'test_helper'

class UserTest < Minitest::Test

  def setup
    @user = {email: "watson@example.com", zimbraId: "251b1902-2250-4477-bdd1-8a101f7e7e4e", password: "12345"}
  end

  def test_only_set_zimbraId_when_passed_a_zimbraId
    u = ZimbraPreAuthRouter::User.new(@user[:zimbraId])
    assert_equal(u.zimbraId, @user[:zimbraId])
    assert_nil(u.email)
  end

  def test_only_set_email_when_passed_an_email
    u = ZimbraPreAuthRouter::User.new(@user[:email])
    assert_equal(u.email, @user[:email])
    assert_nil(u.zimbraId)
  end

  def test_return_email_when_passed_just_an_username
    u = ZimbraPreAuthRouter::User.new("watson")
    assert_equal(u.email, @user[:email])
    assert_nil(u.zimbraId)
  end

  def test_should_load_db_user_file_to_global_hash
    assert_equal(ZimbraPreAuthRouter::User.DB.class, Hash)
  end

  def test_db_should_have_emails_when_email_is_passed
    assert(ZimbraPreAuthRouter::User.DB["watson@example.com"])
  end

  def test_return_true_if_migrated_user_with_zimbraId
    u = ZimbraPreAuthRouter::User.new("7b562ce0-be97-0132-9a66-482a1423458f")
    assert(u.migrated?, "Failure message.")
  end

  def test_return_false_if_not_migrated_user_with_zimbraId
    u = ZimbraPreAuthRouter::User.new("7b562ce0-be97-0132-9a66-482a14234333")
    assert(!u.migrated?, "Failure message.")
  end

  def test_return_true_if_migrated_user_with_email
    u = ZimbraPreAuthRouter::User.new(@user[:email])
    assert(u.migrated?, "Failure message.")
  end

  def test_return_false_if_no_migrated_user_with_email
    u = ZimbraPreAuthRouter::User.new("pbruna")
    assert(!u.migrated?, "Failure message.")
  end
  
  def test_return_new_backend_url_if_migrated
    u = ZimbraPreAuthRouter::User.new(@user[:email])
    assert_equal(ZimbraPreAuthRouter::Config.new_backend_url, u.backend_url)
  end
  
  def test_return_old_backend_url_if_migrated
    u = ZimbraPreAuthRouter::User.new("pbruna")
    assert_equal(ZimbraPreAuthRouter::Config.old_backend_url, u.backend_url)
  end
  
  def test_should_return_emtpy_hash_if_not_migration_file_exist
    ZimbraPreAuthRouter::Config.migrated_users_file = "/tmp/null"
    assert_equal({}, ZimbraPreAuthRouter::User.DB)
    ZimbraPreAuthRouter::Config.migrated_users_file="./test/fixtures/users.yml"
  end
  
  def test_should_return_emtpy_hash_if_file_is_nil
    ZimbraPreAuthRouter::Config.migrated_users_file = nil
    assert_equal({}, ZimbraPreAuthRouter::User.DB)
    ZimbraPreAuthRouter::Config.migrated_users_file="./test/fixtures/users.yml"
  end
  

end