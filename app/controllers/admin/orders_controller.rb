class Admin::OrdersController < Admin::AdminController
  belongs_to :user
  
  create.wants.html {redirect_to collection_url}
  update.wants.html {redirect_to collection_url}

  def set_as_paid
    @user = User.find(params[:id])
    @user.order.update_attribute("state", "confirmed")
    redirect_to admin_users_path
  end
end
