class MemberMailer < ActionMailer::Base
  def watch_received_email(user, watch)
    @watch = watch
    @user = user
  end
end