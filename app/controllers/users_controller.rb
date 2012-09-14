class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  
  before_filter :authenticate_user!
  
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def modify_profile
    current_user.update_attributes(:building_id => params[:user][:building_id], :major => params[:user][:major], :major2 => params[:user][:major2], :minor => params[:user][:minor], :minor2 => params[:user][:minor2], :year => params[:user][:year], :about_me => params[:about_me])

    respond_to do |format|
      format.html {redirect_to user_profile_path(:user => current_user.id)}
      format.js
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def profile
	if params[:user]
		@user = User.find(params[:user])
		@topics = @user.topics(:order => "created_at DESC")
		@posts = @user.posts.order("created_at DESC")
	else
		@user = current_user
	end
  
	respond_to do |format|
		format.html
	end
  end
  
  def classmates
	@my_courses = current_user.courses.where("quarters.term='Fall 2012'")
	@classmates = []
	@course = Course.find(params[:course])
	relevent_quarters = Quarter.where(:term => "Fall 2012")
	relevent_quarters.each do |q|
		q.courses.each do |c|
			if @course.id == c.id
				unless q.user == current_user
					@classmates << q.user
				end
			end
		end
	end
  
	respond_to do |format|
		format.html
	end
  end

  def alt_profile
    if params[:user]
      @user = User.find(params[:user])
      @topics = @user.topics(:order => "created_at DESC")
      @posts = @user.posts.order("created_at DESC")
    else
      @user = current_user
    end
      @quarters = @user.quarters
      @this_quarter = @quarters.where(:term => "Fall 2012").first
    
    respond_to do |format|
      format.html
    end
  end

  def add_major_minors
    respond_to do |format|
      format.html
      format.js
    end
  end
  
end
