class Api::UsersController < Api::BaseController
	
	def show
		@users = User.all
    @user = User.find(params[:id])
    #respond_200(@user) 
  end

end
