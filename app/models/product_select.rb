require 'munkres'
class ProductSelect
  def distance(product, request)
    request['set']
    request['avg']
  end
  def initialize(products, users, scalars)
    matrix = []
    @averages = []
    @scalars = scalars
    requests users.map{|user| user.requests() }
    @user_ids = users.map{|user| user.id }
    @product_ids = products.map{|product| product.id}

    products.each_with_index{ |i, product|
      product = product.toVector()
      requests.each_with_index{ |j ,request|
        matrix[i][j] = distance(product, request, j)
      }
    }
    @matrix = matrix
  end

  def find_pairs
    m = Munkres.new(@matrix)
    m.find_pairings.map{|pairs|
      [@user_ids[pairs[0]], @product_ids[pairs[1]]]
    }
  end

  def distance(product, request, j)
    if(request.include?(product))
      return 0
    end
    req_avg = @averages[j] ||= average(request)

    dist_sqrd = 0
    (product.keys | request.keys).each{|key|
      scale_key = key.split('-')[0]
      scale = (@scalars[scale_key] || 1)
      p = product[key] || 0
      r = request[key] || 0
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
        avg[key] +=  val / num_items
      }
    }
    return avg
  end
end