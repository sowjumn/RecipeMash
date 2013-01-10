require 'spec_helper'

describe User do

   before do 
      @user = User.new(name: "Example", email: "example@user.com")
   end

   it {should respond_to(:name) }
  

   subject { @user } 
   
   it {should be_valid }
   
   describe "when name is not present" do
     before { @user.name = " " }
     it {should_not be_valid}
   end

   describe "when email is not present" do
      before { @user.email = " " }
      it {should_not be_valid}
    end

   describe "when name is too long" do
      before { @user.name = "a"*51 }
      it {should_not be_valid}
   end

end
