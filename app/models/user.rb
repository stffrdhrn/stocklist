class User < ActiveRecord::Base
  attr_accessible :name
  has_many :stocks, :dependent => :destroy

  def self.init(name)
    u = User.create({:name => name})
    s = Stock.create({:name => 'Household'})

    s.user = u

    s.products.push(Product.all)
    s.save
  end
end
