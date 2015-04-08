module ZimbraPreAuthRouter
  class User
    attr_accessor :email, :zimbraId, :password, :timestamp
    
    include OpenSSL

    # user_identifier can be an email address, zimbraId UUID or just the
    # local part of an email address, like user in user@example.com
    def initialize(user_identifier, password = nil)
      @zimbraId = set_zimbraId user_identifier
      @email = set_email user_identifier
      @password = password
      @timestamp = DateTime.now.strftime('%Q')
    end
    
    def backend_url
      return ZimbraPreAuthRouter::Config.new_backend_url if migrated?
      ZimbraPreAuthRouter::Config.old_backend_url
    end
    
    def pre_authkey
      return ZimbraPreAuthRouter::Config.new_preauth_key if migrated?
      ZimbraPreAuthRouter::Config.old_preauth_key
    end
    
    def compute_preauth
      plaintext="#{email}|name|0|#{timestamp}"
      key=pre_authkey

      hmacd=HMAC.new(key, OpenSSL::Digest.new('sha1'))
      hmacd.update(plaintext)
      hmacd.to_s
    end
    
    def preatuh_url
      string = "service/preauth?expires=0&"
      string << "account=#{email}&"
      string << "timestamp=#{timestamp}&"
      string << "preauth=#{compute_preauth}"
      string
    end

    # If user has email (unless email.nil?)
    def migrated?
      !find_in_db.nil?
    end

    def find_in_db
      return User.DB[email] if has_email?
      return User.DB.invert[zimbraId] if has_zimbraId?
    end

    def has_email?
      !email.nil?
    end

    def has_zimbraId?
      !zimbraId.nil?
    end
    
    def login
      ZimbraPreAuthRouter::Login.new(self)
    end

    def self.load_migrated_users
      begin
        db = YAML.load_file ZimbraPreAuthRouter::Config.migrated_users_file
      rescue Exception => e
        db = Hash.new
      end
      return {} unless db
      db
    end

    def self.DB
      load_migrated_users
    end

    private
    def set_zimbraId user_identifier
      return user_identifier if UUID.validate user_identifier
      nil
    end

    def set_email user_identifier
      return user_identifier if user_identifier.match(/@/)
      return "#{user_identifier}@#{ZimbraPreAuthRouter::Config.domain}" unless UUID.validate user_identifier
      nil
    end


  end

end