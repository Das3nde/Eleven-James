class Notify < ActionMailer::Base
  #default from: "from@example.com"

  def contact(contact)
    @contact = contact
    mail to: 'contact@elevenjames.com', from: @contact.email, subject: @contact.subject
  end


end
