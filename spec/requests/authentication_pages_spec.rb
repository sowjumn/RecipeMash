require 'spec_helper'

describe "AuthenticationPages" do

	subject { page } 

	describe "Signin page" do
		before { visit signin_path }

	#	it { should have_selector('title',text: "Sign In") }
		it { should have_selector('h1',text: "Sign In") }
	end

	describe "Signin" do
		before { visit signin_path }
		
		describe "with invalid information" do
			before { click_button "Sign In" }
			#it { should have_selector('title', text: 'Sign In') }			
			it { should have_selector('div.alert.alert-error', text: 'Invalid') }
		end

		#Check for flash errors
		describe "after visiting another page" do
			before { click_button "Home" }
			it { should_not have_selector(div.alert.alert-error) }
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) } 
			
		 	before { sign_in(user)	}		

			it { should have_link('Home', href: root_url) }
			it { should have_link('Profile', href: user_path(user)) }			
			it { should have_link('Log Out', href: signout_path) }
			it { should have_button('Edit Profile') }
			it { should_not  have_link('Sign In', href: signin_path) }
		end
	end

end
