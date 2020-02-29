class PostsController < ApplicationController

    before_action :find_post, only: [:show, :edit, :update, :destroy]
    before_action :find_user, only: [:new, :create, :show, :edit, :update]

    def index 
        @post = Post.all
    end

    def new 
        @post = Post.new
    end

    def create
        @post = @user.posts.create(post_params)
        if @post.save
            redirect_to user_post_path(@user, @post.id)
        else
            render 'new'
        end
    end

    def show
    end

    def edit
    end

    def update
        @post.update(post_params)
        redirect_to user_post_path(@user, @post.id)
    end

    def destroy
        @post.destroy
        redirect_to user_path
    end

    private

    def find_user
        @user = User.find(params[:user_id])
    end

    def find_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :content)
    end
end
