module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
    when /the new admin page/
      new_admin_path
    when /the admin login page/
      admin_login_path
    when /the admin list of admin users/
      admin_users_path(:role => 'admin')
    when /the admin list of users/
      admin_users_path
    when /the admin list of pages/
      admin_pages_path
    when /the admin edit configuration/
      edit_admin_configuration_path(1)
    when /the admin list of questions/
      admin_questions_path
    when /the login page/
      login_path
    when /the user page/
      user_path(2)
    when /the register page/
      '/users/new'
    when /the Home page/
      '/pages/home'
    when /the About Us page/
      '/pages/about-us'
    when /the Contact page/
      '/pages/contact'

    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
  
end

World(NavigationHelpers)
