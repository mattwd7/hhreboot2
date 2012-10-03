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

    def destroy
      @post = @topic.posts.find(params[:id])
      if @post.owner_or_admin?(forem_user)
        @post.destroy
        if @post.topic.posts.count == 0
          @post.topic.destroy
          flash[:notice] = t("forem.post.deleted_with_topic")
          redirect_to [@topic.forum]
        else
          flash[:notice] = t("forem.post.deleted")
          redirect_to [@topic.forum, @topic]
        end
      else
        flash[:alert] = t("forem.post.cannot_delete")
        redirect_to [@topic.forum, @topic]
      end

    end
end