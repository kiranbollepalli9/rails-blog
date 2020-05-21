class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "Logged In successfully"
            redirect_to user
            

        else 
            flash.now[:alert] = "Either Email or Password is wrong."
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged Out successfully"
        redirect_to root_path
    end

end