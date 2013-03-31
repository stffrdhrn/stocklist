class Product < ActiveRecord::Base
  attr_accessible :category, :name, :type

  has_many :product_stocks
  has_many :stocks, :through => :product_stocks

  belongs_to :user
end
