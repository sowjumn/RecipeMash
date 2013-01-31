class SessionsController < ApplicationController
	layout "sessions"

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
	
		else
			flash[:error] = "Invalid email/password combination"
			render 'new'
		end
	end


	def destroy

	end

end
