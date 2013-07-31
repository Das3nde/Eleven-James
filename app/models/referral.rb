class Referral < ActiveRecord::Base
  attr_accessible :user_id, :email, :name
  validates :user_id, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false, :scope => [:user_id], message: 'already referred by you'

  belongs_to :user
end
