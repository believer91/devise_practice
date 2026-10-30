class MypagesController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
  end

  private

  def require_login
    redirect_to root_path unless user_signed_in?
  end
end