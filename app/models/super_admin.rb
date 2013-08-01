class SuperAdmin < ActiveRecord::Base

  attr_accessible :email, :password

  validates :email, presence: true
  validates :password, presence: true

  before_validation :strip_email

  def strip_email
    self.email = self.email.to_s.strip
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    self.password_hash = SuperAdmin.encrypted_password(@password)
  end

  def self.encrypted_password(pwd)
    Digest::SHA1.hexdigest(pwd)
  end

end
