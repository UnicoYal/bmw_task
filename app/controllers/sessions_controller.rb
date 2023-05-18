# frozen_string_literal: true

# session controller
class SessionsController < ApplicationController
  before_action :no_autorize, only: %i[new create]
  before_action :autorize, only: :destroy
  def new
    $param = params[:param]
  end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password]) # Для безопасности(Если юзер будет nil,
      # то к нему не применится метод и мы направимся в else)
      if ($param == '0' && user.role == 0) || ($param == '1' && user.role == 1) 
        session[:user_id] = user.id
        flash[:success] = 'Успешный вход'
        redirect_to home_path
      else
        flash[:warning] = 'Неправильный email или пароль'
        redirect_to session_path
      end
    end
  end

  def destroy
    session.delete :user_id
    flash[:success] = 'Успешный выход'
    redirect_to home_path
  end
end