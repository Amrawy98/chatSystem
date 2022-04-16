class AppsController < ApplicationController
  def index
    apps = App.order('created_at DESC').as_json(except: :id);
    render json: {status: 'SUCCESS', message: 'read applications', data: apps}, status: :ok
  end

  def show
    app = App.find_by(token: params[:id]).as_json(except: :id);
    render json: {status: 'SUCCESS', message: 'read application', data: app}, status: :ok
  end

  def create
    app = App.new(app_params);
    if app.save
      render json: {status: 'SUCCESS', message: 'created application', data: app.as_json(except: :id)}, status: :ok
    else
      render json: {status: 'ERROR', message: 'failed to create application', data: app.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    app = App.find_by(token: params[:id])
    if app
      app.destroy
      render json: {status: 'SUCCESS', message: 'deleted an application', data: app.as_json(except: :id)}, status: :ok
    else
      render json: {status: 'ERROR', message: 'no app with given token' }, status: :not_found
    end
  end

  def update
    app = App.find_by(token: params[:id])
    if app
      app.with_lock do
        app.name = params[:name]
        app.save!
        render json: { status: 'SUCCESS', message: 'Updated application', data: app.as_json(except: :id) }, status: :ok
      end
    else
      render json: { status: 'ERROR', message: 'no app with given token' }, status: :not_found
    end
  end

  private

  def app_params
    params.permit(:name)
  end
end
