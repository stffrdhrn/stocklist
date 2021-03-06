class Product < ActiveRecord::Base
  # CATEGORIES
  KITCHEN_GOODS = "KGDS"
  FOOD = "FOOD"
  LIVING_GOODS = "LGDS"
  BATHROOM_GOODS = "BGDS"
  CLEANING_GOODS = "CGDS"
  # TYPE
  USER = "USER"
  DEFAULT = "DFLT"

  attr_accessible :category, :name, :ownership

  has_many :product_stocks
  has_many :stocks, :through => :product_stocks

  belongs_to :user

  def self.all_excluding_stocklist(user,stocklist)
    # If you give this query an empty list it returns nothing, 
    # add dummy value to return something

    ids = stocklist.products.map(&:id)
    ids.push(-99)

    Product.where('(user_id = ? or ownership = ?) and id not in (?)', user.id, DEFAULT, ids)
  end

  def self.all_for_user(user) 
    Product.where('user_id = ? or ownership = ?', user.id, DEFAULT)
  end

end
