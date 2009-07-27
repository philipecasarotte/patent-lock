class Admin::OrdersController < Admin::AdminController
  belongs_to :user
  
  create.wants.html {redirect_to collection_url}
  update.wants.html {redirect_to collection_url}

end
