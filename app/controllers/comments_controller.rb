class CommentsController < ApplicationController
    before_action :authenticate_user!
  
def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.build(comment_params)
  @comment.user = current_user

  if @comment.save
    redirect_to post_path(@post), notice: "Comment added successfully!"
  else
    redirect_to post_path(@post), alert: "Error adding comment."
  end
end
  
    def destroy
      @comment = Comment.find(params[:id])
      if @comment.user == current_user || current_user.admin?
        @comment.destroy
        redirect_to root_path, notice: "Comment deleted."
      else
        redirect_to root_path, alert: "You can only delete your own comments."
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content, :store_link)
    end
  end
  