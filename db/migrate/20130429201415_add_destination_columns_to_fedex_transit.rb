class AddDestinationColumnsToFedexTransit < ActiveRecord::Migration
  def change
    add_column :fedex_transits, :destination_record, :string
    add_column :fedex_transits, :origin_record, :string
  end
end
