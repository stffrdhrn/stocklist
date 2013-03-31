class ProductStock < ActiveRecord::Base
  attr_accessible :quantity
  belongs_to :stock
  belongs_to :product
end
