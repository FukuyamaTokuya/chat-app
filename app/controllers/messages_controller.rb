class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
  end

  def create
 
   if Message.create(create_params)
  
    redirect_to room_messages_path(params[:room_id])
   else
    render :index
    end
    #別の書き方
    # @room = Room.find(params[:room_id])
    # @message = @room.messages.new(message_params)
    # if @message.save
    #   redirect_to room_messages_path(@room)
    # else
    #   render :index
    # end


  end

  private
    def create_params
      params.require(:message).permit(:content).merge(room_id: params[:room_id], user_id: current_user.id)
    end

end
