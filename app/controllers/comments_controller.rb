class CommentsController < ApplicationController
  before_action :require_logged_in

  def new
    @comment = Comment.new(post_id: params[:post_id], parent_comment_id: params[:parent_comment_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post_id = @comment.post_id
    @comment.destroy
    redirect_to post_url(@post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content, :parent_comment_id)
  end

  def require_logged_in
    redirect_to new_sessions_url unless logged_in?
  end
end
