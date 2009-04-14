class AccessToken<OauthToken
  validates_presence_of :user
  before_create :set_authorized_at, :set_expires_on
  
  def to_query
    resource_names = ""
    resource_urls = ""
    self.client_application.resources.each do |r|
      resource_names += "&resources[]=" + r.name
      resource_urls += "&resource_urls[]=" + r.child_sp.base_url
    end
    "oauth_token=#{token}&oauth_token_secret=#{secret}#{resource_names}#{resource_urls}&expires_on=#{expires_on.to_i}"
  end
  
  def within_resource_scope?(resource)
    @token.resources.collect {|resource| resource.name}.include?(params[:resource])
  end
  
  def expired?
    expires_on < Time.now
  end
  
  def authorized?
    authorized_at!=nil && !invalidated? && !expired?
  end  
  
  protected 
  
  def set_authorized_at
    self.authorized_at=Time.now
  end
  
  def set_expires_on
    self.expires_on=Time.now + 60*60*24*7 # TODO: Need to set this expiration offset in a configuration file, currently set to 1 week
  end
end