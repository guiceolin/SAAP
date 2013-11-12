class UserMailer < ActionMailer::Base
  default from: "saap@ceol.in"

  def welcome_mail(user)
    @user = user
    mail(to: user.email, subject: t('mailer.user.welcome.subject'))
  end
end
