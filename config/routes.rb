ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.login 'login', :controller => "user_sessions", :action => "new"
    admin.logout 'logout', :controller => "user_sessions", :action => "destroy"
    admin.resource :user_session
    admin.resources :questions, :collection=>{ :reorder=>:get, :order=>:post }
    admin.resources :pages, :collection=>{ :reorder=>:get, :order=>:post }
    admin.resources :users, :has_one => :order
    admin.set_as_paid "/admin/users/:id/order/paid", :controller => "orders", :action => "set_as_paid"
    admin.resources :configurations
    admin.root :controller => 'pages'
  end
  
  map.login "/login", :controller => "user_sessions", :action => "new"
  map.logout "/logout", :controller => "user_sessions", :action => "destroy"
  map.forgot_password "/forgot-password", :controller => "user_sessions", :action => "forgot_password"
  map.forgot_username "/forgot-username", :controller => "user_sessions", :action => "forgot_username"
  map.pages '/pages/:action', :controller => 'pages'
  
  map.questionnaire_step1 "/questionnaire/step-1", :controller => "questionnaire", :action => "step1"
  map.questionnaire_step2 "/questionnaire/step-2", :controller => "questionnaire", :action => "step2"
  
  map.questionnaire_payment "/questionnaire/payment", :controller => "questionnaire", :action => "payment"
  map.questionnaire_terms "/questionnaire/terms", :controller => "questionnaire", :action => "terms"
  map.questionnaire_on_hold "/questionnaire/on_hold", :controller => "questionnaire", :action => "on_hold"
  map.answer_save_and_continue "/questionnaire/save_and_continue", :controller => "questionnaire", :action => "save_and_continue"
  map.questionnaire_questions "/questionnaire/:action/:position", :controller => "questionnaire"
  map.resources :pages
  map.resource :user_session
  map.resources :users
  
  map.not_found '/404', :controller => 'pages', :action => '404'
  map.application_error '/500', :controller => 'pages', :action => '500'
  map.unprocessable_entity '/422', :controller => 'pages', :action => '422'
  map.root :controller => 'pages', :action => 'index'
end

