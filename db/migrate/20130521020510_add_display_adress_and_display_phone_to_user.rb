class AddDisplayAdressAndDisplayPhoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :display_address, :boolean, :default => true
    add_column :users, :display_phone, :boolean, :default => true
  end
end
