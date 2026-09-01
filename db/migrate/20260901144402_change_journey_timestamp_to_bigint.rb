class ChangeJourneyTimestampToBigint < ActiveRecord::Migration[8.1]
  def change
    change_column :journeys, :timestamp, :bigint
  end
end
