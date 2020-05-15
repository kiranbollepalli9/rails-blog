class PostsController < ApplicationController
    
    before_action :set_post, only: [:edit, :show, :update, :destroy ]

    def index
        @posts = Post.all;
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
end
