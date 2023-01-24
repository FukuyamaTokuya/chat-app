class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id]) #現在いるroomのレコード取得
    @messages= @room.messages.includes(:user) #チャットルームに紐づいてる全てのメッセージ取得
  end

  def create

    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user) #renderでindexviewに行くときに@messagesを定義していないとエラーになるので追加
      render :index
    end
     #別の書き方１
  #  if Message.create(create_params)
  #   redirect_to room_messages_path(params[:room_id])
  #  else
  #   render :index
  #  end


  end

  private
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
  #別の書き方１
  # def create_params
    #   params.require(:message).permit(:content).merge(room_id: params[:room_id], user_id: current_user.id)
    # end


end
