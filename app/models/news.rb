class News < ActiveRecord::Base

  attr_accessible :title, :date, :description,  :image, :status


  validates :title, presence: true

  has_attached_file :image, :styles => {
      :thumb => '100x100#',
      :square => '200x200#',
      :public => '359x293#'
  }

  scope :published, where(:status => 'publish')

  def self.latest_news
    where("date > ?", Time.now).order("date ASC").first
  end

end
