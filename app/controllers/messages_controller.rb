class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json

  before_filter :authenticate_user!

  def index
    @messages = current_user.messages
	current_user.update_attributes(:new_messages => false)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
  @message = Message.new
	@reply = params[:re]
	@template = params[:msg_template]
  @recipient = User.find(params[:recipient])
  @subject
  if params[:course]
    @book = params[:book_desc]
    @course = Course.find(params[:course])
    @subject = "I want your #{@course.title} textbook!"
  end
  if params[:classmates]
      @message_course = params[:message_course]
      @classmates_message = true
  end
  if params[:from_profile]
    @from_profile = true
    @user = User.find(params[:user_id])
  end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(:subject => params[:subject], :text => params[:text], :user_id => current_user.id, :recipient_id => params[:recipient_id])
	  @user = User.find(params[:recipient_id])
    @user.update_attributes(:new_messages => true)
    if params[:about_a_book]
      UserMailer.textbook_request(@user).deliver
    end

    respond_to do |format|
      if @message.save
        if params[:about_a_book]
          format.html { redirect_to find_books_path(:book => params[:course_id]), notice: 'Your message has been sent.' }
          format.json { render json: @message, status: :created, location: @message }
        elsif params[:classmates]
          format.html {redirect_to classmates_path(:course => params[:course]), notice: 'Your message has been sent.' }
        elsif params[:from_profile]
          format.html { redirect_to user_profile_path(:user => params[:user_id]), notice: 'Your message has been sent.' }
        else
          format.html { redirect_to my_messages_path }
        end          
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to my_messages_url }
      format.json { head :no_content }
    end
  end
  
  def my_messages
	@new_messages = Message.where(:recipient_id => current_user.id).where(:trashed => false).order("created_at DESC")
  @sent_messages = Message.where(:user_id => current_user.id).where(:trashed => false).order("created_at DESC").first(10)
  @trashed_messages = Message.where(:recipient_id => current_user.id).where(:trashed => true).order("created_at DESC")
  if @new_messages.where(:unread => true).count > 0
    current_user.update_attributes(:new_messages => true)
  else
    current_user.update_attributes(:new_messages => false)
  end
  #Clean out all users week-old, trashed messages
  #@old_trash = Message.where(:trashed => true).where("(? - trash_time) < ?", Time.now, 30000)
  
	respond_to do |format|
		format.html
	end
  end
  
  def view_message
  	@message = Message.find(params[:msg_id])
  	@message.update_attributes(:unread => false)
  	
  	if Message.where(:recipient_id => current_user.id, :unread => true).empty?
  		current_user.update_attributes(:new_messages => false)
  	end
    
  	respond_to do |format|
  		format.html
  	end
  end

  def trash_message
    @message = Message.find(params[:msg_id]).update_attributes(:trashed => true, :trash_time => Time.now)
    @trashed_messages = Message.where(:recipient_id => current_user.id).where(:trashed => true).order("created_at DESC")
    @new_messages = Message.where(:recipient_id => current_user.id).where(:trashed => false).order("created_at DESC")
    if @new_messages.where(:unread => true).count > 0
      current_user.update_attributes(:new_messages => true)
    else
      current_user.update_attributes(:new_messages => false)
    end
  
    
    respond_to do |format|
      format.html {redirect_to my_messages_path}
      format.js
    end
  end

  def restore_message
    @message = Message.find(params[:msg_id]).update_attributes(:trashed => false, :trash_time => nil)
    @new_messages = Message.where(:recipient_id => current_user.id).where(:trashed => false).order("created_at DESC")
    @trashed_messages = Message.where(:recipient_id => current_user.id).where(:trashed => true).order("created_at DESC")
    if @new_messages.where(:unread => true).count > 0
      current_user.update_attributes(:new_messages => true)
    else
      current_user.update_attributes(:new_messages => false)
    end

    respond_to do |format|
      format.html {redirect_to my_messages_path}
      format.js
    end
  end
  
end
