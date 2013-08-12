class Event < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :description, :drop_off, :pickup, :state, :subhead, :title, :venue, :zip,
                  :date, :start_time, :end_time, :image


  validates :title, presence: true

  has_attached_file :image, :styles => {
      :thumb => '100x100#',
      :square => '200x200#',
      :public => '359x293#'
  }

  def self.recently_upcoming
    where("date > ?", Time.now).order("date ASC").first
  end

end
