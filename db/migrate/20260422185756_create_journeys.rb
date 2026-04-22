class CreateJourneys < ActiveRecord::Migration[8.1]
  def change
    create_table :journeys do |t|
      t.belongs_to :user
      t.integer :timestamp
      t.text :uuid

      t.timestamps
    end
  end
end
