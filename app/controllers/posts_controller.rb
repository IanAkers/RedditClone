class PostsController < ApplicationController

  def new
    @post = Post.new
    @sub_id = params[:sub_id]
    debugger
  end

  def create
    @post = current_user.authored_posts.new(post_params)
    if @post.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = [@post.errors.full_messages]
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @sub_id = params[:sub_id]
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = [@post.errors.full_messages]
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    sub_id = @post.sub_id
    @post.destroy
    redirect_to sub_url(sub_id)
  end


  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids:[])
  end

end
