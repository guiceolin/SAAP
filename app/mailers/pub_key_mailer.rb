class PubKeyMailer < ActionMailer::Base
  default from: 'saap@ceol.in'

  def new_key_added_mail(user, key)
    @user = user
    @key = key
    mail(to: user.email, subject: t('mailer.pub_key.new_key_added.subject'))
  end

  def key_removed_mail(user, key)
    @user = user
    @key = key
    mail(to: user.email, subject: t('mailer.pub_key.key_removed.subject'))
  end
end
