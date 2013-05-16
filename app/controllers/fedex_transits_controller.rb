#Receives emails from fedex regarding shipping notifications
class Admin::FedexTransitsController < Admin::RecordsController
  def create

    record = FedexTransits.new()
    record.expected_start_time = pickup_time
    record.expected_end_time = pickup_time + duration
    record.tracking_number = trk
    record.address = params[address]
    record.save()
  end
  def update params
    trk = get_tracking_number(params)
    action = get_action(params)
    time = 12345
    record = FedexTransits.where("tracking_number = ?",trk)
    item = ProductInstance.find(record.product_id)
    status = item.status();

    if record.end_time
      return
    end
    if record.start_time && status.id != record.id
        msg = 'Record has a start time but no end time and is not the current record. tracking number:#{trk}'
    elsif status.id != record.prev().id
        msg = 'Fedex picked up package but the Fedex Transit record isn\'t the item\'s next record. tracking number:#{trk}'
    end
    if msg
      raise(RuntimeError,msg)
    end
    item.advance_record(time)
  end
  def preview_pickup

  end
  def get_tracking_number params

  end
  def get_action params

  end
  def get_time params

  end
end
