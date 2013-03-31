class Stock < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
  has_many :product_stocks
  has_many :products, :through => :product_stocks
end
