class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy ]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @users = User.paginate(page: params[:page], per_page: 3)

    end

    def new
        @user = User.new
    end

    def show
        @posts = @user.posts.paginate(page: params[:page], per_page: 3)
    end

    def edit
    end

    def create
        @user = User.new(form_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
            redirect_to posts_path
        else
            render 'new'
        end
    end

    def update
        if @user.update(form_params)
            flash[:notice] = " #{@user.username} was updated sucessfully! "
            redirect_to @user
        else 
            render 'edit'
        end        
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "Account and all associated articles successfully deleted"
        redirect_to root_path
    end


    private

    def form_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
          flash[:alert] = "You can only edit your own account"
          redirect_to @user
        end
    end
    

end