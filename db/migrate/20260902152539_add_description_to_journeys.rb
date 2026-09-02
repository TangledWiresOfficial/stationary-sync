class AddDescriptionToJourneys < ActiveRecord::Migration[8.1]
  def change
    add_column :journeys, :description, :text
  end
end
