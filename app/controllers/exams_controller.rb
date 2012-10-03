class ExamsController < ApplicationController
	
	#before_filter :authenticate_user!

	def test_bank
		if current_user
			@my_classes = @my_classes = current_user.quarters.where(:term => @current_term).first.courses if current_user.quarters.where(:term => @current_term).first
			@exams = Exam.where("user_id != ?", current_user.id)
			@exam_activity = Examrecord.where(:user_id => current_user.id).collect{|record| [record.exam_id, record.vote, record.downloaded]}
			@accessible_exams
			if current_user.accessible_exams != nil
				@accessible_exams = current_user.accessible_exams.split(" ")
			end
		else
			@exams = Exam.all
		end
		@exams.sort! {|a,b| b.created_at <=> a.created_at}
				
		@fields = Field.all
		@courses = Course.all
		if params["field"]
      		@course_list = Field.find(params["field"]).courses
    	end

    	if params[:course]
    		@course = Course.find(params[:course])
    		if current_user
    			@exams = Exam.where(:course_id => params[:course]).where("user_id != ?", current_user.id)
    		else
    			@exams = Exam.where(:course_id => params[:course])
    		end
    	end

    	if params[:new_entries]
    		@exams_voted_on = Examrecord.where(:user_id => current_user.id).collect(&:exam_id)
    		if @exams_voted_on.size > 0
    			@exams = Exam.where("quality < ?", @premium_exam_benchmark).where("user_id != ?", current_user.id).where("id NOT IN (?)", @exams_voted_on)
    		else
    			@exams = Exam.where("quality < ?", @premium_exam_benchmark).where("user_id != ?", current_user.id)
    		end
    		@exams.sort! {|a,b| b.created_at <=> a.created_at}
    	end

    	@current_order
		if params[:order]
			@current_order = params[:order]
				if params[:order] == "by_prof"
					@exams.sort! { |a,b| a.professor <=> b.professor }
				elsif params[:order] == "by_prof_desc"
					@exams.sort! { |a,b| b.professor <=> a.professor }
				elsif params[:order] == "by_quality"
					@exams.sort! { |a,b| b.quality <=> a.quality }
				elsif params[:order] == "by_quality_desc"
					@exams.sort! { |a,b| a.quality <=> b.quality }
				end
		else
			@exams.sort! {|a,b| b.created_at <=> a.created_at}
		end

		respond_to do |format|
			format.html
			format.js
		end
	end

	def my_vault
		@uploaded_exams = Exam.where(:user_id => current_user.id)
		if current_user.accessible_exams != nil
			@accessible_exams = current_user.accessible_exams.split(" ")
		end
		@downloaded_exams = Exam.where("course_id IN (?)", @accessible_exams).where("user_id != ?", current_user.id)
		@downloaded_exams.sort! {|a,b| b.created_at <=> a.created_at}
		@exam_activity = Examrecord.where(:user_id => current_user.id).collect{|record| [record.exam_id, record.vote, record.downloaded]}

    	@current_order
		if params[:order]
			@current_order = params[:order]
				if params[:order] == "by_prof"
					@downloaded_exams.sort! { |a,b| a.professor <=> b.professor }
				elsif params[:order] == "by_prof_desc"
					@downloaded_exams.sort! { |a,b| b.professor <=> a.professor }
				elsif params[:order] == "by_quality"
					@downloaded_exams.sort! { |a,b| b.quality <=> a.quality }
				elsif params[:order] == "by_quality_desc"
					@downloaded_exams.sort! { |a,b| a.quality <=> b.quality }
				elsif params[:order] == "by_filename"
					@downloaded_exams.sort! { |a,b| a.document_file_name <=> b.document_file_name }
				elsif params[:order] == "by_filename_desc"
					@downloaded_exams.sort! { |a,b| b.document_file_name <=> a.document_file_name }
				elsif params[:order] == "by_course"
					@downloaded_exams.sort! { |a,b| a.course.title <=> b.course.title }
				elsif params[:order] == "by_course_desc"
					@downloaded_exams.sort! { |a,b| b.course.title <=> a.course.title }
				end
		end
		respond_to do |format|
			format.html
		end
	end

    def upload_exam
    	@fields = Field.all
		@courses = Course.all
		if params["field"]
      		@course_list = Field.find(params["field"]).courses
    	end
    	if params[:document]
    		@exam = Exam.new(:course_id => params[:course], :user_id => current_user.id, 
    			:professor => params[:professor], :term => params[:term], 
    			:document => params[:document], :description => params[:description])
		    respond_to do |format|
		    	if current_user.legitimate_uploader == false && current_user.uploads >= @upload_limit
		    		format.html { redirect_to upload_exam_path, alert: "You have reached your upload limit (#{@upload_limit}) this quarter without having your existing uploads legitimized." }
				elsif @exam.save
					#after upload actions
					current_user.uploads += 1
					current_user.test_tokens += 1 if (current_user.uploads == 1 || current_user.uploads % 3 == 0)
					current_user.save
					format.html { redirect_to my_vault_path, notice: 'Exam was successfully uploaded.' }
				else
					format.html { render action: "upload_exam" }
				end
		    end
		else
			respond_to do |format|
				format.html
				format.js
			end
		end
	end

	#downloading file from /public: send_file @exam.document.path, :filename => @exam.document_file_name, :type => @exam.document_content_type, :disposition => "attachment"

	def download_exam
		@exam = Exam.find(params[:exam_id])
		@new_download_count = @exam.download_count + 1
		@new_token_count = current_user.test_tokens - 1
		if @exam.quality >= @premium_exam_benchmark
			if Examrecord.where(:user_id => current_user.id).where(:exam_id => @exam.id).size > 0
				send_file @exam.document.path, :filename => @exam.document_file_name,
					:type => @exam.document_content_type, :disposition => "attachment"
			elsif current_user.test_tokens > 0
				send_file @exam.document.path, :filename => @exam.document_file_name,
					:type => @exam.document_content_type, :disposition => "attachment"
				current_user.update_attributes(:test_tokens => @new_token_count)
				@exam.update_attributes(:download_count => @new_download_count)
				Examrecord.create(:user_id => current_user.id, :exam_id => @exam.id, :downloaded => true)
			else
				#error message on Tokens
			end
		else
			send_file "#{@exam.document.path}", :filename => @exam.document_file_name,
				:type => @exam.document_content_type, :disposition => "attachment"
			@exam.update_attributes(:download_count => @new_download_count)
			unless Examrecord.where(:user_id => current_user.id).where(:exam_id => @exam.id).size > 0
				Examrecord.create(:user_id => current_user.id, :exam_id => @exam.id, :downloaded => true)
			end
		end
	end

	def submit_vote
		@exam = Exam.find(params[:exam])
		@record = Examrecord.new(:user_id => current_user.id, :exam_id => @exam.id, :vote => params[:vote])
		@record.save

		respond_to do |format|
			if params[:vote] == "up"
				@exam.quality += 1
				@exam.save
			end
			if params[:vote] == "down"
				@exam.quality -= 1
				if params[:downvote_reason] == "Irrelevant"
					@exam.irrelevant_count += 1
					if @exam.irrelevant_count >= @irrelevant_count_threshold && @exam.quality < 0
						@exam.examrecords.delete_all
						@exam.destroy
					end	
				elsif params[:downvote_reason] == "Duplicate"
					@exam.duplicate_count += 1
					if @exam.duplicate_count >= @duplicate_count_threshold && @exam.quality < 0
						@exam.examrecords.delete_all
						@exam.destroy
					end	
				elsif params[:downvote_reason] == "Misplaced"
					@exam.misplaced_count += 1
					if @exam.misplaced_count >= @misplaced_count_threshold && @exam.quality < 0
						@exam.examrecords.delete_all
						@exam.destroy
					end	
				end
				@exam.save
			end

			#current_user.exam_votes += 1
			#current_user.test_tokens += 1 if current_user.exam_votes % @exam_votes_per_token == 0
			#current_user.save

			if @exam.quality % @upvotes_per_token == 0 && @exam.quality > @exam.prev_best
				@exam.user.test_tokens += 1
				@exam.user.legitimate_uploader = true
				@exam.user.uploads += 1
				@exam.user.save
				@exam.update_attributes(:prev_best => @exam.quality)
			end
			if params[:route] == "my_vault_path"
				format.html {redirect_to my_vault_path}
			elsif params[:route] == "new_entries"
				format.html {redirect_to test_bank_path(:new_entries => true)}
			else
				format.html {redirect_to test_bank_path}
			end
		end	
	end

	def grant_access
		if current_user.test_tokens	> 0
			if Exam.where(:course_id => params[:course]).where("user_id != ?", current_user.id).count != 0
				if current_user.accessible_exams != nil
					current_user.accessible_exams += " #{params[:course]}"
				else
					current_user.accessible_exams = params[:course]
				end
				current_user.test_tokens -= 1
				current_user.save
			else
				flash[:alert] = "There are no exams to gain access to."
			end
		else
			flash[:alert] = "You require a test token to access exams for this course."
		end
		respond_to do |format|
			format.html {redirect_to test_bank_path(:course => params[:course])}
		end
		
	end

end