class LibraryController < ApplicationController

	def my_library
		@books_for_trade = current_user.textbooks.where(:own_it => true)
		@books_seeked = current_user.textbooks.where(:own_it => false)
		@bookless_course_ids = current_user.courses.collect(&:id) - current_user.textbooks.collect(&:course_id)
		@my_courses = Course.find(@bookless_course_ids)
		
		respond_to do |format|
			format.html
		end
	end
	
	def add_book
		@book = Textbook.new(:user_id => current_user.id, :course_id => params[:course_id], :own_it => params[:own_it], :description => params[:description], :terms_of_exchange => params[:terms_of_exchange], :price => params[:price], :condition => params[:condition])
		@my_books = current_user.textbooks.where(:own_it => true)
	
		respond_to do |format|
			if @book.save
				flash[:notice] = "Textbook made available."
				format.js
			else
				flash[:error] = "Unable to add book"
				redirect_to my_library_path
				format.js
			end
		end
	end
	
	def destroy
		@book = Textbook.find(params[:book])
		@book.destroy
		
		respond_to do |format|
			format.html {redirect_to my_library_path}
			format.js
		end
	end
	
	def find_books
		@my_classes = current_user.quarters.where(:term => @current_term).first.courses
		@current_order
		@fields = Field.all
		@courses = Course.all
		if params[:order]
			@current_order = params[:order]
		end
		if params["field"]
      		@course_list = Field.find(params["field"]).courses
    	end
	#	@users_with_books = User.where("username != ?", current_user.username).includes(:textbooks).joins(:textbooks).where("textbooks.course_id = ?", params[:book]).where("textbooks.own_it = ?", true)
		@textbooks = Textbook.where(:own_it => true).where(:course_id => params[:book]).where("user_id != ?", current_user.id)

		if params[:book]
			@course = Course.find(params[:book])
			if params[:order]
				if params[:order] == "by_building"
					@textbooks.sort! { |a,b| a.user.building.name <=> b.user.building.name }
				elsif params[:order] == "by_building_desc"
					@textbooks.sort! { |a,b| b.user.building.name <=> a.user.building.name }
				elsif params[:order] == "by_username"
					@textbooks.sort! { |a,b| a.user.username <=> b.user.username }
				elsif params[:order] == "by_username_desc"
					@textbooks.sort! { |a,b| b.user.username <=> a.user.username }
				elsif params[:order] == "by_price"
					@textbooks.sort! { |a,b| a.price <=> b.price }
				elsif params[:order] == "by_price_desc"
					@textbooks.sort! { |a,b| b.price <=> a.price }
				elsif params[:order] == "by_condition"
					@textbooks.sort! { |a,b| a.condition <=> b.condition }
				elsif params[:order] == "by_condition_desc"
					@textbooks.sort! { |a,b| b.condition <=> a.condition }
				end
			else
				@textbooks.sort! { |a,b| a.user.building.name <=> b.user.building.name }
			end
		end
	
		respond_to do |format|
			format.html
			format.js
		end
	end
	
	def find_trades
		@books_I_want = current_user.textbooks.where(:own_it => false)
		@my_books_for_trade = current_user.textbooks.where(:own_it => true).collect(&:course_id)
		@users_looking_for_books_I_have = Textbook.where(:own_it => false).where("user_id != ?", current_user).where("course_id IN (?)", @my_books_for_trade)
		@users_with_books_I_need = Textbook.where(:own_it => true).where(:course_id => params[:book])
		@traders = @users_looking_for_books_I_have.collect(&:user) & @users_with_books_I_need.collect(&:user)
		@book_titles = Array.new
		
		if params[:book]
			if params[:order]
				if params[:order] == "by_building"
					@traders.sort! { |a,b| a.building.name <=> b.building.name }
				elsif params[:order] == "by_building_desc"
					@traders.sort! { |a,b| b.building.name <=> a.building.name }
				elsif params[:order] == "by_username"
					@traders.sort! { |a,b| a.username <=> b.username }
				elsif params[:order] == "by_username_desc"
					@traders.sort! { |a,b| b.username <=> a.username }
				end
			else 
				@users_with_books = User.where("username != ?", current_user.username).includes(:textbooks).joins(:textbooks).where("textbooks.course_id = ?", params[:book]).where("textbooks.own_it = ?", true).order("username")
			end
		end
		
		
	
		respond_to do |format|
			format.html
		end
	end

	def manage_textbooks
		@my_books = current_user.textbooks.where(:own_it => true)
		@fields = Field.all
		@courses = Course.all
	   	if params["field"]
      		@course_list = Field.find(params["field"]).courses
    	end

		respond_to do |format|
			format.html
			format.js
		end	
	end

end