class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_credentials(user_params)
    if user
      log_in(user)
      redirect_to goals_url
    else
      @user = User.new(user_params)
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end
end
