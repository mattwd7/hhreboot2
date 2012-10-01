Hhreboot2::Application.routes.draw do
  
  
  resources :friendships
  resources :messages
  resources :fields
  resources :quarters
  resources :courses
  resources :buildings

  mount Forem::Engine, :at => "/forums"
  devise_for :users, :controllers => {:registrations => "registrations", confirmations: "confirmations"}

  resources :users

#  root :to => 'navigation#homepage'
  root :to => 'navigation#alt_homepage'
  
  match 'new_topics' => 'topics#new_topics'

  match 'owner_area' => 'owner#owner_area'
  match 'insert_class' => 'owner#insert_class'
  match 'custom_script' => 'owner#custom_script'
  match 'review_test_bank_entries' => 'owner#review_test_bank_entries'
  
  match 'homepage' => 'navigation#alt_homepage'
  match 'hot_topics' => 'navigation#hot_topics'
  match 'newest_topics' => 'navigation#newest_topics'
  match 'building_leaders' => 'navigation#building_leaders'
  match 'add_major_minor' => 'navigation#add_major_minor'
  match 'top_posters' => 'navigation#top_posters'
  match 'sandbox' => 'navigation#sandbox'
  match 'update_courses' => 'navigation#update_courses'
  match 'about' => 'navigation#about'
  match 'roadmap' => 'navigation#roadmap'
  match 'dining_menu' => 'navigation#dining_menu'

  match 'test_bank' => 'exams#test_bank'
  match 'upvote' => 'exams#upvote'
  match 'downvote' => 'exams#downvote'
  match 'submit_vote' => 'exams#submit_vote'
  match 'my_vault' => 'exams#my_vault'
  match 'upload_exam' => 'exams#upload_exam'
  match 'upload_page' => 'exams#upload_page'
  match 'download_exam' => 'exams#download_exam'
  match 'inspect_exams' => 'exams#inspect_exams'
  match 'grant_access' => 'exams#grant_access'

  match 'my_messages' => 'messages#my_messages'
  match 'create_message' => 'messages#create'
  match 'view_message' => 'messages#view_message'
  match 'reply_to_message' => 'messages#reply_to_message'
  match 'trash_message' => 'messages#trash_message'
  match 'restore_message' => 'messages#restore_message'
  match 'destroy_message' => 'messages#destroy'
  
  match 'user_profile' => 'users#alt_profile'
  match 'alt_profile' => 'users#alt_profile'
  match 'classmates' => 'users#classmates'
  match 'modify_profile' => 'users#modify_profile'
  match 'add_major_minors' => 'users#add_major_minors'
  match 'add_friend' => 'friendships#create'

  match 'destroy_quarter' => 'quarters#destroy'
  match 'list_fields' => 'fields#list'
  match 'input_course_data' => 'courses#add_data'
  
  match 'my_library' => 'library#my_library'  
  match 'add_book' => 'library#add_book'  
  match 'destroy_book' => 'library#destroy'  
  match 'find_trades' => 'library#find_trades'  
  match 'find_books' => 'library#find_books'  
  match 'three_way_trades' => 'library#three_way_trades'  
  match 'manage_textbooks' => 'library#manage_textbooks'  
  
  match 'list_courses' => 'courses#list'
  match 'add_course_to_quarter' => 'courses#add_course_to_quarter'
  match 'remove_course_from_quarter' => 'courses#remove_course_from_quarter'
  match 'manage_classes' => 'courses#manage_classes'

  match 'building_page' => 'buildings#building_page'

  
#  match 'add_courses' => 'courses#add_data'
#  match 'add_buildings' => 'buildings#add_data'

  
  
end
