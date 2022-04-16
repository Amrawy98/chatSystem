class MessagesController < ApplicationController

  def index
    messages = Message.where(app_token: params[:app_token], chat_number: params[:chat_number])
    render json: { status: 'SUCCESS', message: 'read messages', data: messages }, status: :ok
  end

  def show
    message = Message.find_by(app_token: params[:app_token], chat_number: params[:chat_number], number: params[:id])
    if message
      render json: { status: 'SUCCESS', message: 'read message', data: message.as_json(except: [:id,:chat_id]) }, status: :ok
    else
      render json: { status: 'NOT FOUND', message: 'no messages found' }, status: :not_found
    end
  end

  def create
    chat = Chat.find_by(app_id: params[:app_token], number: params[:chat_number])
    if chat
      chat.with_lock do
        message = Message.new(
          number: chat.last_message_number + 1,
          content: params[:content],
          chat_id: chat.id,
          app_token: params[:app_token],
          chat_number: params[:chat_number]
        )
        message.save!
        chat.message_count += 1
        chat.last_message_number += 1
        chat.save!
        render json: { status: 'SUCCESS', message: 'created message', data: message.as_json(except: [:id,:chat_id]) }, status: :ok
      end
    else
      render json: {status: 'ERROR', message: 'no chat with given number and token'}, status: :not_found
    end
  end

  def update
    message = Message.find_by(app_token: params[:app_token], chat_number: params[:chat_number], number: params[:id])
    if message
      message.with_lock do
        message.content = params[:content]
        message.save!
        render json: { status: 'SUCCESS', message: 'updated message', data: message.as_json(except: [:id,:chat_id]) }, status: :ok
      end
    else
      render json: { status: 'NOT FOUND', message: 'no messages found' }, status: :not_found
    end
  end

  def destroy
    chat = Chat.find_by(app_id: params[:app_token], number: params[:chat_number])
    message = Message.find_by(app_token: params[:app_token], chat_number: params[:chat_number], number: params[:id])
    if chat and message
      chat.with_lock do
        message.destroy!
        chat.message_count -= 1
        chat.save!
        render json: { status: 'SUCCESS', message: 'deleted message', data: message.as_json(except: [:id,:chat_id]) }, status: :ok
      end
    else
      render json: { status: 'NOT FOUND', message: 'no messages found' }, status: :not_found
    end
  end
end
