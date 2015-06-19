class SubsController < ApplicationController
  before_action :ensure_moderator_is_current_user, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
        redirect_to user_url(current_user)
    else
      redirect_to new_sub_url
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to user_url(current_user)
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def ensure_moderator_is_current_user
    redirect_to :back if (current_user.nil? || current_user.id != Sub.find(params[:id]).user_id)
  end

end
