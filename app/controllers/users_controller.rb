class UsersController < ApplicationController
   before_filter :authenticate, :only =>   [:index, :edit, :update, :destroy]
   before_filter :correct_user, :only => [:edit, :update]
   before_filter :admin_user,   :only => :destroy
   before_filter :logged_in,    :only => [:new, :create]
   before_filter :delete_self,  :only => :destroy 

def index
    @title = "All users"
   # @users = User.all
    @users = User.paginate(:page => params[:page])
  end

def show
    @user = User.find(params[:id])
     @title = @user.name
  end

def new
 #  @title = "Sign up now"
  #  if @user.name != nil
  #      flash[:success] = "TEST."
  #        redirect_to(root_path)
  #  else  
       @user = User.new
       @title = "Sign up"
    end
#  end
def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
    #  @user.password = nil #.clear
    #  @user.password_confirmation = nil    #.clear   nil 
      @title = "Sign up"
      render 'new'
    end
   end
def edit
   # @user = User.find(params[:id])
    @title = "Edit user"
  end
def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

def destroy
   # User.find(params[:id]).destroy
    @user =  User.find(params[:id])
   # if @user.admin?
   #   if current_user.admin?
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
       redirect_to users_path
end

 private

    def logged_in
     # deny_access if signed_in?
        if signed_in?
        #   redirect_to(root_path)
      # flash[:success] = "User destroyed."
      #  @user = User.find(params[:id])
       # if current_user?
        redirect_to(root_path) #unless current_user?(@user)
        end
      end

    def authenticate
      deny_access unless signed_in?
    end

   def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

   def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

   def delete_self
     @user =  User.find(params[:id])
       session[:cur_user_name] = current_user.name
       if @user.name == current_user.name
      flash[:notice] = "Admins can not delete their Accounts."
      redirect_to users_path 
       end
    end 
 end
