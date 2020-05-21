class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update]
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


    private

    def form_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

end