class AddFeatureToUser < ActiveRecord::Migration
  def change
    add_column :users, :feature, :boolean , :default => false
  end
end
