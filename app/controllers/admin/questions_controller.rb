class Admin::QuestionsController < Admin::AdminController
  
  include PositionOrder
  
  create.wants.html {redirect_to collection_url}
  update.wants.html {redirect_to collection_url}
  
end
