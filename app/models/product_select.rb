require 'munkres'
class ProductSelect
  def distance(product, request)
    request['set']
    request['avg']
  end
  def initialize(product_instances, users, scalars = {})
    matrix = []
    @averages = []
    @scalars = scalars
    requests =  users.map{|user| user.request_vectors() }
    @user_ids = users.map{|user| user.id }
    @product_ids = product_instances.map{|instance| instance.id}
    products = product_instances.map{|instance| instance.product}

    @matrix = generate_matrix(products, requests)
  end

  def generate_matrix(products, requests)
    matrix = []
    products.each_with_index{ |product, i|
      product = product.to_vector()
      matrix[i] = []
      requests.each_with_index{ |request ,j|
        matrix[i][j] = product && request ? distance(product, request, j) : 0
      }
    }

    matrix
  end

  def get_matrix
    @matrix
  end

  def find_pairs
    #If we don't clone the matrix, the Munkres will alter the existing matrix. this makes testing super difficult
    cost_matrix = []

    @matrix.each do |arr|
      cost_matrix << arr.clone()
    end

    m = Munkres.new(cost_matrix)
    parings = m.find_pairings
    #returns an array of pairs, in the form [product_id, user_id]
    parings.map{|pairs|
      [@product_ids[pairs[0]], @user_ids[pairs[1]]]
    }
  end

  def distance(product, request, j)
    if(request.include?(product))
      return 0
    end
    req_avg = @averages[j] ||= average(request)
    dist_sqrd = 0
    (product.keys | req_avg.keys).each{|key|
      scale_key = key.split('-')[0]
      scale = (@scalars[scale_key] || 1)
      p = product[key] || 0
      r = req_avg[key] || 0
      dist_sqrd +=  (p - r)**2
    }
    Math.sqrt(dist_sqrd)
  end
  def average(request)
    avg = {}
    num_items = request.size
    request.each{ |product|
      product.each{ |key, val|
        avg[key] ||= 0
        avg[key] +=  1.0 * val / num_items
      }
    }
    return avg
  end

  def self.performance
    times = []
    (1..30).each do |i|
      puts 'generated '+i.to_s+' pairings'
      matrix = Array.new(i*10){Array.new(i*10){rand} }
      c = Munkres.new(matrix)
      start = Time.now
      c.find_pairings
      times << Time.now - start
    end
    return times
  end
end