class MessagesController < ApplicationController
	before_action :set_message, only: [:show, :update, :destroy]

	def index
		@messages = Message.all
		json_response(@messages)
	end

	def show
		json_response(@message)
	end

	def create
		@message = Message.create!(message_params)
		json_response(@message, :created)
	end

  def update
    @message.update(message_params)
    head :no_content
  end

  def destroy
    @message.destroy
    head :no_content
  end

	private

	def message_params
		params.permit(:message, :user_id)
	end

  def set_message
    @message = Message.find(params[:id])
  end
end
