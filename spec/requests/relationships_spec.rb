require 'spec_helper'

require 'faker'


describe "Users" do

   before(:each) do

   @user = Factory(:user)

   @other_user = Factory(:user, {

                      :name  => Faker::Name.name,
                      :email => Factory.next(:email)
                       })
    integration_sign_in(@user)

   end

   describe "follow a user" do

  
   it "should make a new relationship" do

        lambda do

       click_link "Users"

       click_link @other_user.name

      click_button "Follow"
      end.should change(Relationship, :count).by(1)

      end
  end

    describe "unfollow a user" do

     before(:each) do
     @user.follow!(@other_user)

     end
	
  it "should delete an existing relationship" do

        lambda do

          click_link "Users"

         click_link @other_user.name

        click_button "Unfollow"
      end.should change(Relationship, :count).by(-1)

      end
   end
 end
