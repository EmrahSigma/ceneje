class PostsController < ApplicationController
    def destroy
      @post = Post.find(params[:id])
      
      if @post.destroy
        redirect_to root_path, notice: "Post deleted successfully!"
      else
        redirect_to root_path, alert: "Something went wrong!"
      end
    end
  end