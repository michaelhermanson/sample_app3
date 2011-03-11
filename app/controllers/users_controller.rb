class UsersController < ApplicationController
def show
    @user = User.find(params[:id])
     @title = @user.name
  end

def new
 #  @title = "Sign up now"
    @user = User.new
    @title = "Sign up"
  end
def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @user.password = nil #.clear
      @user.password_confirmation = nil    #.clear   nil 
      @title = "Sign up"
      render 'new'
    end
 
  end

end
