class Course < ActiveRecord::Base
  attr_accessible :category, :description, :enddate, :name, :ongoing, :price, :startdate, :user_id, :coursetimes_attributes
  belongs_to :user
  has_many :coursetimes
  has_many :orders
  validates_presence_of :user_id
  accepts_nested_attributes_for :coursetimes
end
