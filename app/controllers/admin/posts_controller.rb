class Admin::PostsController < Admin::ApplicationController
before_action :verify_logged_in

  def index
    if params[:search]
    @posts = Post.search(params[:search]).all.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
    else
    @posts = Post.all.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
    end
  end

  def new
    @page_title = 'Add Post'
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    if params[:post][:image].blank?
      @post.image = nil
    end

    if @post.save
      flash[:notice] = 'Post Created'
      redirect_to admin_posts_path
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if params[:post][:image].blank?
      @post.image = nil
    end

    if @post.update(post_params)
      flash[:notice] = 'Post Updated'
      redirect_to admin_posts_path
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post Removed'
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :category_id, :user_id, :tags, :image, :body)
  end
end
