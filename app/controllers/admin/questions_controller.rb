class Admin::QuestionsController < Admin::AdminController
  
  include Order
  
  create.wants.html {redirect_to collection_url}
  update.wants.html {redirect_to collection_url}
  
end
