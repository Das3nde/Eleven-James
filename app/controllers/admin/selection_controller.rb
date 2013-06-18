class Admin::SelectionController < AdminController
  def index
    sql = 'select * from product_instances, storage_records where id = product_instance_id and storage_records.is_available is null'
    @users = User.all()
    @products = ProductInstance.where('is_available is true')
  end
  def get_pairs
    product_ids = []
    user_ids = []

    (params[:locked_pairs] || {}).each do |k, pair|
      product_ids << pair[0]
      user_ids << pair[1]
    end
    products =  product_ids.empty? ? ProductInstance.all : ProductInstance.where('id not in (?)',product_ids)
    users =  user_ids.empty? ? User.all : User.where('id not in (?)',user_ids)
    ps = ProductSelect.new(products, users)
    pairs = ps.find_pairs()
    render :json => pairs
  end
  def distribute
    pairs = params[:pairs]
    pairs.each do |k, arr|
      product = ProductInstance.find(arr[0])
      user = User.find(arr[1])
      product.add_rotation(user)
    end
    render :json => {:ok => true}
  end
end