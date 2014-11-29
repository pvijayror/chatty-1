class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id   # user_id in message is the user_id of the sender
    @message.save!

    @path = conversation_path(@conversation)
  end

  private
  # Allow a message json which has body element in json
  def message_params
    params.require(:message).permit(:body)
  end
end