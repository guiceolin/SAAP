module Messages
  class MessagesController < ApplicationController
    respond_to :json
    skip_before_filter :verify_authenticity_token

    def index
      @deliveries = current_user.deliveries.includes(:message).where('messages_messages.topic_id' => params[:topic_id]).where('messages_deliveries.readed' => false).to_a
      @deliveries.map{ |d| d.update_attribute(:readed, true) }
      @messages = @deliveries.map(&:message)
    end

    def create
      @topic = Messages::Topic.find(params[:topic_id])
      @message = Messages::Message.new(body: params[:body], sender: current_user, topic: @topic)
      if @message.save
        head :created
      else
        head :unprocessable_entity
        render json: { errors: @message.errors }
      end
    end

  end
end
