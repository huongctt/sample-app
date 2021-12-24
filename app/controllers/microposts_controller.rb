class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.microposts.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = "Micropost deleted"
      redirect_to request.referrer || root_url
    else
      flash[:notice] = 'Can not delete micropost'
      render 'static_pages/home'
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    if @micropost.nil?
      flash[:notice] = 'It is not your post, you can not delete it'
      redirect_to root_url
    end
  end
end