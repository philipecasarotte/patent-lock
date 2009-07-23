class Admin::ConfigurationsController < Admin::AdminController
  
  update.wants.html {redirect_to(edit_admin_configuration_path(1))}
  
end
