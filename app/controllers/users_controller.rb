class UsersController < ApplicationController
  def edit
  end

  def update
    # user=User.find(params[:id])
    # user.update(update_user)
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
