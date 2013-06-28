class Referral < ActiveRecord::Base
  attr_accessible :user_id, :email
  validates :user_id, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false, :scope => [:user_id], message: 'already referred by you'
end
