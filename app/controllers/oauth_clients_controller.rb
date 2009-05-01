class OauthClientsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  
  def index
    @client_applications=current_user.client_applications
  end

  def new
    @client_application=ClientApplication.new
    @resources = Resource.find(:all)
  end

  def create
    @client_application=current_user.client_applications.build(params[:client_application])
    if @client_application.save
      flash[:notice]="Registered the information successfully"
      redirect_to oauth_client_path(@client_application)
    else
      render :action=>"new"
    end
  end
  
  def show
    @client_application=current_user.client_applications.find(params[:id])
  end

  def edit
    @client_application=current_user.client_applications.find(params[:id])
    @resources = Resource.find(:all)
  end
  
  def update
    @client_application=current_user.client_applications.find(params[:id])
    if @client_application.update_attributes(params[:client_application])
      flash[:notice]="Updated the client information successfully"
      redirect_to :action=>"show",:id=>@client_application.id
    else
      render :action=>"edit"
    end
  end

  def destroy
    @client_application=current_user.client_applications.find(params[:id])
    @client_application.destroy
    flash[:notice]="Destroyed the client application registration"
    redirect_to :action=>"index"
  end
end
