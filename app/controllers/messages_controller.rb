class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
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
  if params[:course]
    @course = params[:course]
    @subject = "I want your #{@course} textbook(s)!"
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
	   User.find(params[:recipient_id]).update_attributes(:new_messages => true)

    respond_to do |format|
      if @message.save
        format.html { redirect_to my_messages_path, notice: 'Your message has been sent.' }
        format.json { render json: @message, status: :created, location: @message }
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
  @sent_messages = Message.where(:user_id => current_user.id).where(:trashed => false).order("created_at DESC")
  @trashed_messages = Message.where(:recipient_id => current_user.id).where(:trashed => true).order("created_at DESC")
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
  
    
    respond_to do |format|
      format.html {redirect_to my_messages_path}
      format.js
    end
  end

  def restore_message
    @message = Message.find(params[:msg_id]).update_attributes(:trashed => false, :trash_time => nil)
    @new_messages = Message.where(:recipient_id => current_user.id).where(:trashed => false).order("created_at DESC")
    @trashed_messages = Message.where(:recipient_id => current_user.id).where(:trashed => true).order("created_at DESC")

    respond_to do |format|
      format.html {redirect_to my_messages_path}
      format.js
    end
  end
  
end
