# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.create({:category => Product::KITCHEN_GOODS, :name => 'Foil', :ownership => Product::DEFAULT})
Product.create({:category => Product::KITCHEN_GOODS, :name => 'Plastic Wrap', :ownership => Product::DEFAULT})
Product.create({:category => Product::KITCHEN_GOODS, :name => 'Dish Soap', :ownership => Product::DEFAULT})
Product.create({:category => Product::KITCHEN_GOODS, :name => 'Sponge', :ownership => Product::DEFAULT})
Product.create({:category => Product::FOOD, :name => 'Milk', :ownership => Product::DEFAULT})
Product.create({:category => Product::FOOD, :name => 'Egges', :ownership => Product::DEFAULT})
Product.create({:category => Product::FOOD, :name => 'Bread', :ownership => Product::DEFAULT})
Product.create({:category => Product::FOOD, :name => 'Jam', :ownership => Product::DEFAULT})
Product.create({:category => Product::LIVING_GOODS, :name => 'Tissue', :ownership => Product::DEFAULT})
Product.create({:category => Product::CLEANING_GOODS, :name => 'Laundry Detergent', :ownership => Product::DEFAULT})
Product.create({:category => Product::BATHROOM_GOODS, :name => 'Toilet Paper', :ownership => Product::DEFAULT})
Product.create({:category => Product::BATHROOM_GOODS, :name => 'Shampoo', :ownership => Product::DEFAULT})
Product.create({:category => Product::BATHROOM_GOODS, :name => 'Toothpaste', :ownership => Product::DEFAULT})
User.init('Stafford Horne', 'shorne@gmail.com', 'password', 'password')
