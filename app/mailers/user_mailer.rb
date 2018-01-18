class UserMailer < ActionMailer::Base

  default :from => "localhost:3000"

  def registration_confirmation(user)
      @user = user
      mail(:to => "#{user.name} <#{user.email}, :subject => "Registration Confirmation for Awesome App)
  end
  
end
