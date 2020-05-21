class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
    end

    def edit
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(form_params)
        if @user.save
            flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
            redirect_to posts_path
        else
            render 'new'
        end
    end

    def update
         @user = User.find(params[:id])
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

end