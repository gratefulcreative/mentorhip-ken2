class AddDisplayInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :displayInfo, :boolean , :default => true
    add_column :users, :approved, :boolean, :default => false
  end
end
