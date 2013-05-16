class ProductImage < ActiveRecord::Base
  belongs_to :product
  # attr_accessible :title, :body
  attr_accessible :image

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :image, :styles => {
      :thumb => '100x100>',
      :square => '200x200#',
      :medium => '300x300>'
  }

end
