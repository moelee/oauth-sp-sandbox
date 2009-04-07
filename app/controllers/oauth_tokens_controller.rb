class OauthTokensController < ApplicationController
  before_filter :login_required
  
  def index
    @tokens=current_user.tokens.find :all, :conditions=>'oauth_tokens.invalidated_at is null and oauth_tokens.authorized_at is not null'
  end
  
  def show
    @token=current_user.tokens.find(params[:id])
  end
end
