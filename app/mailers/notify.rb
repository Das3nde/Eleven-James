class Notify < ActionMailer::Base
  #default from: "from@example.com"

  def contact(contact)
    @contact = contact
    mail to: 'contact@elevenjames.com', from: @contact.email, subject: @contact.subject
  end

  def ipn(params)
    @params = params
    mail to: 'rohan@happyfuncorp.com', from: 'rohan@happyfuncorp.com', subject: 'ipn'
  end

  def invitation(name, email, message)
    @name = name
    @message = message
    mail to: email, from: 'contact@elevenjames.com', subject: 'ElevenJames Invitation'
  end
end
