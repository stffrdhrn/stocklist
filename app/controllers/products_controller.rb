class ProductsController < ApplicationController

  def index 

    if params[:excludingStocklist] 
      stocklist = Stock.find(params[:excludingStocklist])
    end

    @products = Product.where('id not in (?)', stocklist.products.map(&:id))
    render :json => @products
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
