class Purchaser < ActiveRecord::Base
  attr_accessible :user_attributes, :firstname, :lastname, :weburl
  has_one :user, :as => :details
  accepts_nested_attributes_for :user
end
