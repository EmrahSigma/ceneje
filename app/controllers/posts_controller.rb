class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :price)
  end

  def check_admin
    redirect_to root_path, alert: 'You are not authorized to create posts.' unless current_user.admin?
  end
end