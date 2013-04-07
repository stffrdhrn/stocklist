class ProductsController < ApplicationController

  def index 

    @products = nil
    if params[:excluding] 
      stocklist = Stock.find(params[:excluding])
      @products = Product.all_excluding_stocklist(stocklist)
    else 
      @products = Product.all
    end

    render :json => @products, :status => :ok
  end

  def create
    @product = Product.new
    @product.category = params[:category]
    @product.name = params[:name]
    @product.ownership = Product::USER

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
      render :json => {:error => "Failed to delete product" }, :status => :forbidden
    end
  end

end
