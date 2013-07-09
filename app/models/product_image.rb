class ProductImage < ActiveRecord::Base
  belongs_to :product

  # attr_accessible :title, :body
  attr_accessible :image, :product_id, :rank

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :image, :styles => {
      :thumb => '100x100#',
      :square => '200x200#',
      :public => '359x293',
      :medium => '600x600>'
  }

  validates_attachment :image, :presence => true,
                       :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }

  def method_missing(meth, *args, &blk)
    image.send(meth, *args, &blk)
  rescue NoMethodError
    super
  end

end
