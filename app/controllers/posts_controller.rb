class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: "Post updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path, notice: "Post deleted successfully!"
    else
      redirect_to root_path, alert: "Something went wrong!"
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :price, :image)
  end
end
