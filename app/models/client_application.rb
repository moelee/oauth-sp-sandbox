require 'oauth'
class ClientApplication < ActiveRecord::Base
  belongs_to :user
  has_many :tokens,:class_name=>"OauthToken"
  has_many :resource_scopes, :dependent => :destroy
  has_many :resources, :through => :resource_scopes
  validates_presence_of :name,:url,:key,:secret
  validates_uniqueness_of :key
  before_validation_on_create :generate_keys
  after_validation_on_create :associate_resources
  after_validation_on_update :associate_resources
  
  attr_accessor :resource_ids
  
  def self.find_token(token_key, resource)
    token=OauthToken.find_by_token(token_key.token, :include => :client_application)
    logger.info "Loaded #{token.token} which was authorized by (user_id=#{token.user_id}) on the #{token.authorized_at}"
    return token if token.authorized?(resource)
    nil
  end
  
  def self.verify_request(request, options = {}, &block)
    begin
      signature=OAuth::Signature.build(request,options,&block)
      logger.info "Signature Base String: #{signature.signature_base_string}"
      logger.info "Consumer: #{signature.send :consumer_key}"
      logger.info "Token: #{signature.send :token}"
      return false unless OauthNonce.remember(signature.request.nonce,signature.request.timestamp)
      value=signature.verify
      logger.info "Signature verification returned: #{value.to_s}"
      value
    rescue OAuth::Signature::UnknownSignatureMethod=>e
      logger.info "ERROR"+e.to_s
     false
    end
  end
  
  def oauth_server
    @oauth_server||=OAuth::Server.new "http://your.site"
  end
  
  def credentials
    @oauth_client||=OAuth::Consumer.new key,secret
  end
    
  def create_request_token
    RequestToken.create :client_application=>self
  end
  
  protected
  
  def generate_keys
    @oauth_client=oauth_server.generate_consumer_credentials
    self.key=@oauth_client.key
    self.secret=@oauth_client.secret
  end
  
  def associate_resources
    # Destroy previous association
    self.resource_scopes.each {|resource_scope| resource_scope.destroy }
    
    # Create associations
    resource_ids.each do |resource_id|
      self.resources << Resource.find(resource_id.to_i)
    end
  end
end
