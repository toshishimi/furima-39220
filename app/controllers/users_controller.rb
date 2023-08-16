class UsersController < ApplicationController

  def edit
  end
  
  def update
    current_user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date)
  end

end
