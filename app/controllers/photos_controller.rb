class PhotosController < ApplicationController
  before_filter :login_or_oauth_required
  before_filter :find_user
  
protected

  def find_user
    if @current_token # This should be set of an oauth request
      @user = @current_user
    else
      @user = User.find(params[:user_id]) if params[:user_id]
    end
  end
  
public
  
  # GET /photos
  # GET /photos.xml
  def index
    @photos = Photo.find(:all) or (!@user.nil? and @user.photos)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos.to_xml(:methods => :public_filename) }
      format.json  { render :json => @photos.to_json(:methods => :public_filename) }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = @user.photos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo.to_xml(:methods => :public_filename) }
      format.json  { render :json => @photo.to_json(:methods => :public_filename) }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = @user.photos.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo.to_xml(:methods => :public_filename) }
      format.json  { render :json => @photo.to_json(:methods => :public_filename) }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = @user.photos.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = @user.photos.new(params[:photo])

    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(@photo) }
        format.xml  { render :xml => @photo.to_xml(:methods => :public_filename), :status => :created, :location => @photo }
        format.json  { render :json => @photo.to_json(:methods => :public_filename), :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        format.json  { render :json => @photo.errors, :status => :created, :location => @photo }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = @user.photos.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(user_photo_path(@user, @photo)) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        format.json  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = @user.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
end
