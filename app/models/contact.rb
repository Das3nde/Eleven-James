class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :subject, :message

  validates :name, presence: true
  validates :email, presence: true
  validates :subject, presence: true
  validates :message, presence: true

  after_create :send_notification

  def send_notification
    Notify.contact(self).deliver
  end

end
