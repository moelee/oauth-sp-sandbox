class OauthToken < ActiveRecord::Base
  belongs_to :client_application
  belongs_to :user
  validates_uniqueness_of :token
  validates_presence_of :client_application,:token,:secret
  before_validation_on_create :generate_keys
  
  def invalidated?
    invalidated_at!=nil
  end
  
  def invalidate!
    update_attribute(:invalidated_at,Time.now)
  end
  
  def authorized?
    authorized_at!=nil && !invalidated?
  end
  
  def to_query
    resource_names = ""
    resource_urls = ""
    self.client_application.resources.each do |r|
      resource_names += "&resources[]=" + r.name
      resource_urls += "&resource_urls[]=" + r.base_url
    end
    "oauth_token=#{token}&oauth_token_secret=#{secret}#{resource_names}#{resource_urls}&expires_on=#{expires_on}"
  end
    
  protected
  
  def generate_keys
    @oauth_token=client_application.oauth_server.generate_credentials
    self.token=@oauth_token[0]
    self.secret=@oauth_token[1]
  end
  
end
