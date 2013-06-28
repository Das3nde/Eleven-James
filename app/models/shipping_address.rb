class ShippingAddress < Address

  after_create :mark_selected

  def mark_selected
    if self.addressable_type == 'User'
      user = User.find(self.addressable_id)
      if user.shipping_addresses.length == 1
        self.selected_shipping = true
        self.save
      end
    end
  end

end