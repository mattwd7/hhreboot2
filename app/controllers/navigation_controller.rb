class NavigationController < ApplicationController

	require 'open-uri'

	def homepage
		respond_to do |format|
			format.html
		end
	end
	
	def alt_homepage
		@subtitles = 
			["Your ResHall Resource"]
		@rand_subtitle = @subtitles[rand(@subtitles.count)]
		respond_to do |format|
			format.html
			format.js
		end
	end
	
	def hot_topics	
		respond_to do |format|
			format.html
		end
	end
	
	def newest_topics	
		@topics = Forem::Topic.all
	
		respond_to do |format|
			format.html
		end
	end
	
	def building_leaders	
		respond_to do |format|
			format.html
		end
	end
	
	def top_posters	
		respond_to do |format|
			format.html
		end
	end
	
	def add_major_minor
		respond_to do |format|
			format.html
			format.json { render :json => @users}
		end
	end

	def about
		respond_to do |format|
			format.html
		end		
	end

	def roadmap
		respond_to do |format|
			format.html
		end
	end
	
	def sandbox
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

	def dining_menu
		respond_to do |format|
			format.html
		end
	end
	
end