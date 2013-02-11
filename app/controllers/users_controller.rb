class UsersController < ApplicationController

	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update, :destroy]

	def index
			redirect_to current_user
	end		

	
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
	end

	def update
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

  def destroy
		 User.find(params[:id]).destroy
		 flash[:notice] = "Your Profile is deleted. We miss you"
		 redirect_to root_path
	end
		


	private
		
		def signed_in_user		
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in!! "
			end
		end

		def correct_user
			@user = User.find(params[:id])
			unless current_user?(@user) 
				flash[:error] = "Dont access other users info!!!!" 
				redirect_to root_url 
			end
		end
end
