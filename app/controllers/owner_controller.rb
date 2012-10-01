class OwnerController < ApplicationController

	def owner_area
		@access_token = "User confirmed"

		respond_to do |format|
			if current_user.owner
				format.html
			else
				format.html {redirect_to homepage_path}
			end
		end		
	end

	def insert_class
		@fields = Field.all
	    @courses = Course.all
	    if params["field"]
	      @course_list = Field.find(params["field"]).courses
	    end

		respond_to do |format|
			if current_user.owner
				if params[:new_course_title]
					@course = Course.find(params[:course_id])
					
					@new_course = Course.new(:field_id => @course.field.id, :title => params[:new_course_title])
					@new_course.queue = @course.queue + 1
					@new_course.save

					@courses_after = Course.where(:field_id => @course.field.id).where("queue > ?", @course.queue).order(:queue)
					@courses_after.each do |c|
						c.queue += 1
						c.save
					end
				end

				format.html
				format.js
			else
				format.html {redirect_to homepage_path}
				format.js
			end
		end			
	end

	def custom_script
		respond_to do |format|
			if current_user.owner
				#put script here

				format.html {redirect_to owner_area_path}
			else
				format.html {redirect_to homepage_path}
			end
		end
	end

	def review_test_bank_entries
		respond_to do |format|
			if current_user.owner
				@exams = Exam.where("created_at > ?", 1.week.ago)
				@exams.sort! {|a,b| a.created_at <=> b.created_at}

				format.html
			else
				format.html {redirect_to homepage_path}
			end
		end
	end

	def lock_account
		@locked_accounts = User.where("locked_at is not NULL")

		respond_to do |format|
			if current_user.owner
				if params[:lock_username]
					@user = User.where(:username => params[:lock_username])
					if @user.count > 0
						@user = @user.first
						@user.update_attributes(:locked_at => Time.now)
						flash[:notice] = "#{@user.username} account locked at #{@user.locked_at}."
					else
						flash[:alert] = "#{params[:lock_username]} does not exist."
					end
				end
				format.html
			else
				format.html {redirect_to homepage_path}
			end
		end		
	end

	def unlock_account
		respond_to do |format|
			if current_user.owner
				User.find(params[:user_id]).update_attributes(:locked_at => nil)
				format.html {redirect_to lock_account_path}
			else
				format.html {redirect_to homepage_path}
			end
		end
	end

end