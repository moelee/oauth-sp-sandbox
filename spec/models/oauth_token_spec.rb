require File.dirname(__FILE__) + '/../spec_helper'
require 'cgi'

describe RequestToken do
  fixtures :client_applications,:users,:oauth_tokens, :resources, :resource_scopes, :child_sps
  before(:each) do
    @token = RequestToken.create :client_application=>client_applications(:one)
  end

  it "should be valid" do
    @token.should be_valid
  end
  
  it "should not have errors" do
    @token.errors.should_not==[]
  end
  
  it "should have a token" do
    @token.token.should_not be_nil
  end

  it "should have a secret" do
    @token.secret.should_not be_nil
  end
  
  it "should not be authorized" do 
    @token.should_not be_authorized
  end

  it "should not be invalidated" do
    @token.should_not be_invalidated
  end
  
  it "should authorize request" do
    @token.authorize!(users(:quentin))
    @token.should be_authorized
    @token.authorized_at.should_not be_nil
    @token.user.should==users(:quentin)
  end
  
  it "should not exchange without approval" do
    @token.exchange!.should==false
    @token.should_not be_invalidated
  end
  
  it "should not exchange without approval" do
    @token.authorize!(users(:quentin))
    @access=@token.exchange!
    @access.should_not==false
    @token.should be_invalidated
    
    @access.user.should==users(:quentin)
    @access.should be_authorized
  end
  
  it "should generate a valid form-encoded url for the access token" do
    @token.authorize!(users(:quentin))
    @access=@token.exchange!
    generated_query_body = CGI.parse(@access.to_query)
    generated_query_body['resources[]'].should == ['photos', 'address_books']
    generated_query_body['resource_urls[]'].should == ['http://photos.heroku.com', 'http://addressbooks.heroku.com']
    generated_query_body['expires_on'].first.to_i.should be > Time.now.to_i + 60*60*24*7-20
  end
  
end
