class UsersController < ApplicationController
  before_filter :require_permission, only: [:show, :remove_history]

def require_permission
  if current_user != User.find(params[:id])
    redirect_to user_path
    #Or do something else here
  end
end

def show
    @user = User.find(params[:id])
end
  def index
    @users = User.all.page(params[:page]).per_page(9)
  end
  def change_address
  @user = current_user
  end
  
  def history
    @user = User.find(params[:id])
    @orders = current_user.orders.where(bvis: true)
  end
 def remove_history
  @order = Order.find([params[:history]]).first
  @order.bvis = false
  @order.save
  redirect_to(:back)
 end
end
