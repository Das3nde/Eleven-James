module Transit
  def next_record
    @next_record||= next_record_table.to_class.find(next_record_id)
  end
  def next_record= (record)
  end
end