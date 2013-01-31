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
			it { should have_selector('title', text: 'Sign In') }			
			it { should have_selector('div.alert.alert-error', text: 'Invalid') }
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) } 
			before do
				fill_in "Email", with: user.email 
				fill_in "Password", with: user.password
				click_button "Sign In"	
			end
			
			it { should have_link('Log Out', href: signout_path) }
			it { should_not  have_link('Sign In', href: signin_path) }
	end

end
