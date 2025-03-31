class HomeController < ApplicationController
  before_action :authenticate_user! 
  def index
    @posts = Post.all # Fetch all posts
    @post = Post.new  # Initialize a new post for the form
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      if params[:post][:image].present?
        @post.image.attach(params[:post][:image])  # Attach the uploaded image
      end
      
      redirect_to root_path, notice: "Post created successfully!"
    else
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :price, :image) # Use :image instead of :image_url
  end

  
end
