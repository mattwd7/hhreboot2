# app/decorators/controllers/forem/topics_controller_decorator.rb

Forem::TopicsController.class_eval do

    def create
      authorize! :create_topic, @forum
      @topic = @forum.topics.build(params[:topic])
      if params[:anonymous_post]
      	@topic.user = User.where(:username => "Anonymous").first
      else
      	@topic.user = forem_user
      end
      if @topic.save
        flash[:notice] = t("forem.topic.created")
        redirect_to [@forum, @topic]
      else
        flash.now.alert = t("forem.topic.not_created")
        render :action => "new"
      end
    end

end