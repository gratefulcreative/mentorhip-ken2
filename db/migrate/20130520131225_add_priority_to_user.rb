class AddPriorityToUser < ActiveRecord::Migration
  def change
    add_column :users, :priority, :integer, :default => 100
  end
end
