class Admin::SelectionController < AdminController
  require 'json'
  @@tabs = {
    index: 'Select',
    history: 'Past Selections',

  }
  def index
    sql = 'select * from product_instances, storage_records where id = product_instance_id and storage_records.is_available is null'
    @users = User.all()
    @products = ProductInstance.where('is_available is true')
    if request.xhr?
      s = Chronic.parse('3 weeks 5 days from now')
      @start_date = Time.new(s.year, s.month) + 2.days
      t = Chronic.parse('11 weeks from now',:now => s)
      @end_date = Time.new(t.year, t.month) - 2.days
      render :file => 'admin/selection/selection'
    end
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

      product.add_rotation(user, Chronic.parse(params[:start_date]),Chronic.parse(params[:end_date]))
    end
    Selection.create({
                      pairings: pairs.to_json,
                      date: Time.now
                  })
    render :json => {:ok => true}
  end

  def history
    @history = []
    Selection.order('date DESC').each do |s|
      pairs = ActiveSupport::JSON.decode(s.pairings).values
      @history << {pairs: pairs.map{|p| [ProductInstance.find(p[0]),User.find(p[1])]}, date: s.date}
    end
  end
  private
    def set_tabs
      @tabs = {
          index: 'Select',
          history: 'Past Selections',

      }
    end


end