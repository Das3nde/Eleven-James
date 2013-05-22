class Record < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  attr_accessible :bin_number, :due_date, :end_date, :id, :int, :product_id, :start_date, :table
  belongs_to :temporal, :polymorphic => true, :dependent => :destroy
  def self.find(id)
    generic = super(id)
    if !generic
      return null
    end
    return generic.table.classify.constantize.find(id)
  end
end