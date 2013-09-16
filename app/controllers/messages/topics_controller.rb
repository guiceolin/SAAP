class Messages::TopicsController < ApplicationController
  respond_to :html

  def new
    @topic = Messages::Topic.new
    respond_with @topic
  end

  def create
    @topic = Messages::Topic.new(topic_params)
    @topic.creator = current_user
    if @topic.save
      redirect_to messages_path
    else
      render :new
    end
  end

  private

  def topic_params
    params[:messages_topic].permit(:circle_id, :circle_type, :include_professor, :subject)
  end
end
