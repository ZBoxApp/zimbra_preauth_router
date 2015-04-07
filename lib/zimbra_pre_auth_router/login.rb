module ZimbraPreAuthRouter
  
  class Login
    attr_accessor :user, :zm_auth_token
    
    def initialize(user)
      @user = user
      @zm_auth_token = set_token
    end
    
    def valid?
      !@zm_auth_token.nil?
    end
    
    def set_token
      result = authenticate!
      return result.value unless result.nil?
      nil
    end
    
    def authenticate!
      clnt = HTTPClient.new
      headers = {"content-type" => "application/x-www-form-urlencoded", "Cookie" => "ZM_TEST=true"}
      resp = clnt.post("#{user.backend_url}/zimbra/", {"loginOp" => "login", "username" => user.email, "password" => user.password}, headers)
      resp.cookies.select {|n| n.name == "ZM_AUTH_TOKEN"}.first
    end
    
  end
  
end