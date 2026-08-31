class RemoveNameAndEmailFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :name
    remove_column :users, :email
  end
end
