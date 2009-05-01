# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  include SslRequirement
  ssl_required
  
  def ssl_required?
    Rails.env.production?
  end
  
  # Ignore authenticity token checks for now
  skip_before_filter :verify_authenticity_token

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => 'fcd7d9ba2d7b5219e1afaac318f51c12'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
