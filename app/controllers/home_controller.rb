class HomeController < ApplicationController
  before_action :authenticate_user! 
  def index
    @post = Post.new
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @posts = Post.where("title LIKE ? OR description LIKE ?", search_term, search_term)
    else
      @posts = Post.all
    end
  end

  def most_viewed
    # Fetch products with 5 or more views
    @most_viewed_posts = Post.where("views >= ?", 5)
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
