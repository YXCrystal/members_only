class PostsController < ApplicationController

    def index 
        @post = Post.all
    end
    def new 
        @post = Post.new
        @user = User.find(params[:user_id])
    end

    def create
        @user = User.find(params[:user_id])
        @post = @user.posts.create(post_params)
        if @post.save
            redirect_to user_post_path(@user, @post.id)
        else
            render 'new'
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)
    end
end
