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

	describe "authorization" do
			
			describe "for non-signed-in users" do
				let(:user) { FactoryGirl.create(:user) } 
				
				describe "in the Users controller" do
	
					describe "visiting the edit page" do
						before { get edit_user_path(user) }
						specify { response.should redirect_to(signin_path) } 
					end

					describe "submitting to the update action" do
						before { put user_path(user) }
						specify { response.should redirect_to(signin_path) }
					end
				end
				
				describe "friendly forwarding" do
					before do
					 visit edit_user_path(user) 
					 fill_in "Email", with: user.email
					 fill_in "Password", with: user.password
					 click_button "Sign In"				 
					end
				it { should have_selector('h1', text:"Update Profile") }
				end			
		
			end

			describe "for wrong users" do 
				let(:user) { FactoryGirl.create(:user) }
				let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

				before { sign_in user }

				describe "visiting Users#edit page" do
					before { get edit_user_path(wrong_user) }
					specify { response.should redirect_to(root_path) }
					it { should have_selector('div.alert.alert-error', text: 'Dont access other users info!!!!') }
				end

				describe "submitting a Put request to the Users#update action" do
					before { put user_path(wrong_user)	}			
				  specify { response.should redirect_to(root_path) }
				end
			end
		
	
	end
end
