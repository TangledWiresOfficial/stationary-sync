class CreateJourneyParts < ActiveRecord::Migration[8.1]
  def change
    create_table :journey_parts do |t|
      t.belongs_to :journey
      t.string :line
      t.string :station

      t.timestamps
    end
  end
end
