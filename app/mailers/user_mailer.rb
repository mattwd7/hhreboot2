class UserMailer < ActionMailer::Base
  default :from => "mailertester225@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Registration")
  end

  def textbook_request(user)
  	@user = user
    mail(:to => user.email, :subject => "Someone wants to buy your textbook!")
  end
end