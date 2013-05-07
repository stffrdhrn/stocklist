class StocklistController < ApplicationController

  def index 
    @stocklist = Stock.find_all_by_user_id(current_user.id)
    render :json => @stocklist
  end

  def show
    @stocklist = Stock.find(params[:id], :include => :product_stocks )
    @stocklist.product_stocks.each do |sl|
      sl.quantity = !sl.quantity ? 0 : sl.quantity
    end
    render :json => @stocklist.to_json( :include =>  { :product_stocks => { :include => :product } } )
  end

  def create
    @stocklist = Stock.new
    @stocklist.name = params[:name]
    @stocklist.user = current_user

    if @stocklist.save
      render :json => @stocklist
    else 
      render :json => {:error => "Failed to save product" }
    end

  end 

  def save
    @stocklist = Stock.find(params[:id])
  
    if current_user != @stocklist.user 
      render :json => {:status => 'You have not rights to update this!'}, :status => :unauthorized
    end     

    @stocklist.name = params[:name]

    # build a list of all linked products
    linked_products = params[:product_stocks].map{|p| p[:product_id]}

    params[:product_stocks].each do |product_stock|
      psp = product_stock[:product]

      # if the current product doesnt exist, its new create it
      if psp[:id].nil? 
        product = Product.new
        product.ownership = Product::USER
        product.user = current_user
      else
        product = Product.find(psp[:id])
      end

      product.category = psp[:category]
      product.name = psp[:name]

      product.save

      # If product is not linked link it, and update the quantity        
      ps = @stocklist.product_stocks.find_by_product_id product.id

      if ps.nil?
        linked_products.push product.id
        @stocklist.products.push product

        ps = @stocklist.product_stocks.find_by_product_id product.id
      end
      ps.quantity = product_stock[:quantity]
      ps.save
    end


    @stocklist.products.each do |product|
      if !linked_products.include? product.id
         @stocklist.products.delete product
      end
    end
 
    @stocklist.save
 
    render :json => @stocklist.to_json( :include =>  { :product_stocks => { :include => :product } } )
  end

end
