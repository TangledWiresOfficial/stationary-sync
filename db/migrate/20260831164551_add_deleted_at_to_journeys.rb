class AddDeletedAtToJourneys < ActiveRecord::Migration[8.1]
  def change
    add_column :journeys, :deleted_at, :datetime

    add_index :journeys, :deleted_at
    add_index :journeys, [ :user_id, :uuid ], unique: true
  end
end
