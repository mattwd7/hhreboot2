class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end
  
  def add_data
	respond_to do |format|
		format.html
	end  
  end
    
  def list
  	respond_to do |format|
  		format.html
  	end  
  end
  
  def add_course_to_quarter
    @error = false

    if params[:new_class]
      @course = Course.find(params[:new_class][:course])
        if current_user.quarters.where(:term => @current_term).first.courses.where(:id => @course.id).count > 0 #ADD QUARTER = FALL 2012 CHECK
          @error = true
        else
          @course.quarters << Quarter.where(:term => "Fall 2012").where("user_id = ?", current_user.id) 
          @my_courses = current_user.quarters.where(:term => "Fall 2012").first.courses
        end
    else
  	   Course.find(params[:crs_id]).quarters << Quarter.find(params[:qtr_id])
    end
	
  	respond_to do |format|
        format.html { redirect_to user_profile_path(:user => current_user) }
        format.js
  	end
  end
  
  def remove_course_from_quarter
  	Course.find(params[:crs_id]).quarters.delete(Quarter.find(params[:qtr_id]))

  	respond_to do |format|
        format.html { redirect_to user_profile_path(:user => current_user) }
        format.js
  	end
  end

  def manage_classes
    if current_user.quarters.where(:term => "Fall 2012")
      @my_courses = current_user.quarters.where(:term => "Fall 2012").first.courses
    end
    @fields = Field.all
    @courses = Course.all
    if params["field"]
      @course_list = Field.find(params["field"]).courses
    end
    
    respond_to do |format|
      format.html
      format.json { render :json => @users}
      format.js
    end
  end
  
end
