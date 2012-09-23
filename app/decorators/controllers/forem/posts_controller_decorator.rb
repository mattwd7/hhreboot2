Forem::PostsController.class_eval do
    def create
      authorize! :reply, @topic
      if @topic.locked?
        flash.alert = t("forem.post.not_created_topic_locked")
        redirect_to [@topic.forum, @topic] and return
      end
      @post = @topic.posts.build(params[:post])
      if params[:anonymous_post]
      	@post.user = User.where(:username => "Anonymous").first
      else
      	@post.user = forem_user
      end
      if @post.save
        flash[:notice] = t("forem.post.created")
        redirect_to forum_topic_url(@topic.forum, @topic, :page => last_page)
      else
        params[:reply_to_id] = params[:post][:reply_to_id]
        flash.now.alert = t("forem.post.not_created")
        render :action => "new"
      end
    end

    def last_page
      (@topic.posts.count.to_f / Forem.per_page.to_f).ceil
    end
end