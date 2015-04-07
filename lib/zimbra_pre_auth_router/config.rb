module ZimbraPreAuthRouter
  module Config

    def self.domain=(domain)
      @domain = domain
    end

    def self.domain
      @domain
    end

    def self.migrated_users_file=(file)
      @migrated_users_file = file
    end

    def self.migrated_users_file
      @migrated_users_file
    end

    def self.backend_port=(port)
      @backend_port
    end

    def self.backend_port
      @backend_port
    end

    def self.old_backend_url=(old_backend)
      @old_backend = old_backend
    end

    def self.new_backend_url=(new_backend)
      @new_backend = new_backend
    end

    def self.old_backend_url
      @old_backend
    end

    def self.new_backend_url
      @new_backend
    end
    
    def self.new_preauth_key=(token)
      @new_preauth_key = token
    end
    
    def self.old_preauth_key=(token)
      @old_preauth_key = token
    end
    
    def self.new_preauth_key
      @new_preauth_key
    end
    
    def self.old_preauth_key
      @old_preauth_key
    end

  end
end