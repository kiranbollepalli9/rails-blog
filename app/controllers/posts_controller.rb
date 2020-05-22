class PostsController < ApplicationController
    
    before_action :set_post, only: [:edit, :show, :update, :destroy]

    before_action :require_user, except: [:show, :index]

    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @posts = Post.paginate(page: params[:page], per_page: 3)
    end

    def new
        @post = Post.new
    end

    def edit
    end

    def show
      
    end

    def create
        @post = Post.new(post_form_params)
        @post.user = current_user
        if @post.save
            flash[:notice] = " Post was created sucessfully! "
            redirect_to @post
        else 
            render 'new'
        end
    end

    def update
        if @post.update(post_form_params)
            flash[:notice] = " Post was updated sucessfully! "
            redirect_to @post
        else 
            render 'edit'
        end        
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end

    private

        def post_form_params
            params.require(:post).permit(:title, :description)
        end  
        
        def set_post
            @post = Post.find(params[:id])
        end

        def require_same_user
            if current_user != @post.user && !current_user.admin?
                flash[:alert] = "You can only edit or delete your own article"
                redirect_to @post
            end

        end
end
