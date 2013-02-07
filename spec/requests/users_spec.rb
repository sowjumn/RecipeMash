require 'spec_helper'

describe "User Pages" do

	subject { page }


	describe "signup page" do
		before { visit signup_path  }

		let(:submit) { "Create account" }

		describe "with invalid information" do
			it "should not create user" do
				expect {click_button submit}.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }
				it { should have_content("error") }
			end
		end 

		describe "with valid information" do
			before do	
				fill_in "Name", with: "Example User"
				fill_in "Email", with: "user@example.com"
				fill_in "Password", with: "foobar4567"
				fill_in "Confirmation", with: "foobar4567"
			end

			it "should create a user" do
				expect {click_button submit}.to change(User, :count).by(1) 
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit edit_user_path(user) }

		describe "page" do
			it { should have_selector('h1', text:"Update Profile") }
		  it { should have_link('change', href: 'http://gravatar.com/emails') }
		end

		describe "with invalid information" do
			before { click_button "Save Changes" }
			it { should have_content('error') }
		end
	end
end







