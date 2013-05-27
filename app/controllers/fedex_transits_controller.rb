require 'chronic'

#Receives emails from fedex regarding shipping notifications
class Admin::FedexTransitsController < Admin::RecordsController
=begin
  def create

    record = FedexTransits.new()
    record.expected_start_time = pickup_time
    record.expected_end_time = pickup_time + duration
    record.tracking_number = trk
    record.address = params[address]
    record.save()
  end
=end

  def update params
    action = get_action(params['subject'])
    time = get_time(params['body-plain'])
    trk = get_tracking_number(params['subject'])

    transit = FedexTransits.where("tracking_number = ?", trk)
    item = ProductInstance.find(transit.product_id)
    status = item.status();

    if transit.end_time
      return
    end
    if transit.start_time && status.id != transit.id
      raise(RuntimeError, 'Record has a start time but no end time and is not the current record. tracking number:#{trk}')
    elsif status.id != transit.prev().id
      raise(RuntimeError, 'Fedex picked up package but the Fedex Transit record isn\'t the item\'s next record. tracking number:#{trk}')
    end

    item.advance_record(time)
  end

  def get_action subject
    actions = {
        'Delivered' => 'delivery',
        'Picked Up' => 'pickup',
        'Online FedEx Tracking' => 'pickup_requested'
    }
    actions.each_pair do |k, v|
      if (subject.index(k))
        return v
      end
    end

  end

  def get_time(body)
    doc = Nokogiri::HTML(body)
    cells = doc.xpath('//td')
    index = 0
    cells.each() do |cell|
      index+=1
      if (cell.content.index('Delivery date'))
        return Chronic.parse(cells[index].content)
      end
    end
  end

  def get_tracking_number(subject)
    return subject.scan(/\d+/)[0]
  end

  def delivery(transit, time)
    product_instance = transit.product_instance
    next_record = transit.next_record()
    advance_record(transit, next_record, product_instance, time)
  end

  def pickup(transit, time)
    product_instance = transit.product_instance
   # puts transit.record.to_yaml
    prev_record = transit.prev_record()
    advance_record(prev_record, transit, product_instance, time)
  end

  def advance_record(prev, current, product_instance, time)
    prev.end_time = time
    current.start_time = time
    product_instance.record_id = current.id

    ActiveRecord::Base.transaction do
      success = prev.save
      success = current.save && success
      success = product_instance.save && success
    end
  end

  def pickup_request(transit)

  end

  def preview_pickup(transit)

  end
end
