class UsersController < ApplicationController
 
  def show
  	@user = User.find(params[:id])
  end
  
  def update
  	@user = current_user
  	 if @user.update(user_params)
  	 	flash[:notice] = "Success"
  	 	redirect_to user_path(current_user.id)
  	 else
  	 	flash[:notice] = "Fail"
  	 	redirect_to user_path(current_user.id)
  	 end
  end

  private

  def user_params
	params.require(:user).permit(:email, :password, {avatars:[]})
  end

end


#form_for usually relates to the instance variable that u created in controller, method new