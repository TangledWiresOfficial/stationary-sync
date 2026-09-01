class ChangeJourneyTimestampToDatetime < ActiveRecord::Migration[8.1]
  def change
    change_column :journeys, :timestamp, :datetime
  end
end
