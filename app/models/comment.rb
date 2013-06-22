class Comment < ActiveRecord::Base
  attr_accessible :description, :user_id, :product_id, :avatar, :fit_score, :excitement_score, :accuracy_score, :wear_again_score

  validates :description, presence: true
  validates :user_id, presence: true
  validates :product_id, presence: true

  has_attached_file :avatar, :styles => {
      :thumb => '100x100#',
      :square => '200x200#'
  }

  has_many :comment_helps, :dependent => :destroy

  belongs_to :product
  belongs_to :user

  RATING_ATTRIBUTES = {
                          fit_score: { label: 'Fit & Wearability' },
                          excitement_score: { label: 'Excitement' },
                          accuracy_score: { label: 'Accuracy' },
                          wear_again_score: { label: 'Wear Again?' }
                       }
  def positive_helps
    self.comment_helps.where(helpful: true)
  end

  def negative_helps
    self.comment_helps.where(helpful: false)
  end

end
