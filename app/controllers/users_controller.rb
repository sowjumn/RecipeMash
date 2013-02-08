class UsersController < ApplicationController
  def new
	  if signed_in?
      flash[:error] = "Already Signed in: Signout before signing Up as different User"
      redirect_to current_user
    else
     @user = User.new    
      render 'new'
    end
  end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if (@user.update_attributes(params[:user])) 
			sign_in @user
			flash[:success] = "Your Profile is updated"
			redirect_to @user
		else
			render 'edit'
		end
		
	end

 
  def show
      @user = User.find(params[:id])
  end  

  def create
     @user = User.new(params[:user])
     if @user.save
			 sign_in @user
			 flash[:success] = "Welcome to Recipe Mash"
       redirect_to @user
     else
       render 'new'
     end
  end

end
