class ChatsController < ApplicationController
  def index
    chats = Chat.where(app_id: params[:token]).order('created_at DESC').as_json(except: :id)
    render json: {status: 'SUCCESS', message: 'read chats', data: chats}, status: :ok
  end

  def show
    chat = Chat.find_by(app_id: params[:token], number: params[:id]).as_json(except: :id);
    if chat
      render json: {status: 'SUCCESS', message: 'read chat', data: chat}, status: :ok
    else
      render json: {status: 'NOT FOUND', message: 'no chats found'}, status: :not_found
    end
  end

  def create
    app = App.find_by(token: params[:token])
    app.with_lock do
      chat = Chat.new(app_id: params[:token], number: app.last_chat_number + 1)
      chat.save!
      app.chats_count += 1
      app.last_chat_number += 1
      app.save!
      render json: { status: 'SUCCESS', message: 'created chat', data: chat.as_json(except: :id) }, status: :ok
    end
  end

  def destroy
    app = App.find_by(token: params[:token])
    app.with_lock do
      chat = Chat.find_by(app_id: params[:token], number: params[:id])
      chat.destroy!
      app.chats_count -= 1
      app.save!
      render json: { status: 'SUCCESS', message: 'deleted chat', data: chat.as_json(except: :id) }, status: :ok
    end
  end

  # Didn't think there is a need to update chats as the only field provided by the use the associated app token
  # def update
  # end

end
