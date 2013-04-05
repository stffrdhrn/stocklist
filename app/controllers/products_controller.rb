class ProductsController < ApplicationController

  def index 

    if params[:excludingStocklist] 
      stocklist = Stock.find(params[:excludingStocklist])
    end

    # If you give this query an empty list it returns nothing, add dummy calue to return something
    ids = stocklist.products.map(&:id)
    ids.push(-99)

    @products = Product.where('id not in (?)', ids)
    render :json => @products, :status => :ok
  end

  def create
    @product = Product.new
    @product.category = params[:category]
    @product.name = params[:name]
    @product.product_type = 'USER'

    if @product.save
      render :json => @product
    else 
      render :json => {:error => "Failed to save product" }
    end
  end

  def destroy
    @product = Product.find(params[:id]) 
    if @product.product_type == 'USER'
      @product.destroy
      render :json => {:status => :ok}, :status => :ok
    else 
      render :json => {:error => "Failed to save product" }, :status => :forbidden
    end
  end

end
