require 'spec_helper'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe ProductSelect do
  before :all do
    FactoryGirl.create_list(:breitling_product, 10)
    FactoryGirl.create_list(:omega_product, 10)
   # @products = Product.all.to_a
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user2)
    FactoryGirl.create(:product_request)
    FactoryGirl.create(:product_request2)
    FactoryGirl.create(:product_request3)
    FactoryGirl.create(:product_request4)

    Product.all.each do |p|
      p.add_inventory()
    end

    @products = ProductInstance.all.to_a
    @users = User.all.to_a
    @ps = ProductSelect.new(@products, @users)
  end
  describe "#average" do
    before :all do
      @set = [Product.find(1).to_vector, Product.find(11).to_vector]
    end
    it "correctly determines the average of a request set" do
      @ps.average(@set).should eq({"material-Gold"=>0.5, "model-1-model"=>0.5, "style-Breitling"=>0.5, "case_size"=>1.0, "material-Silver"=>0.5, "model-11-model"=>0.5, "style-Omega"=>0.5})
    end
  end
  describe "#generate_matrix" do
    before (:all) do
      @matrix = @ps.get_matrix()
    end
    it "correctly generates a matrix with the distances from users to products" do

      @matrix.length.should eq(@products.size)
      @matrix[0].length.should eq(@users.size)
    end
  end
  describe "#find_pairs" do

    it "finds optimal pairings" do
      @ps.find_pairs().should eq([['00001-1', 2], ['00015-1', 3]])
    end

  end

end
