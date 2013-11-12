class PasswordMailer < ActionMailer::Base
  default from: "saap@ceol.in"

  def reset(user)
    @user = user
    @token = user.password_reset_token
    @email = user.email
    mail(to: @email, subject: '[SAAP] - Recuperação de senha' )
  end
end
