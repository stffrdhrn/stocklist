class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  has_many :stocks, :dependent => :destroy

  validates :name, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true  

  def self.init(name, email, password, password_confirmation)
    u = User.create({:name => name, 
                     :email => email, 
                     :password => password, 
                     :password_confirmation => password_confirmation})
    s = Stock.create({:name => 'Household'})

    s.user = u

    s.products.push(Product.all)
    s.save
  end
end
