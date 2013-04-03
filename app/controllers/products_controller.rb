class ProductsController < ApplicationController

  def index 

    if params[:excludingStocklist] 
      stocklist = Stock.find(params[:excludingStocklist])
    end

    @products = Product.where('id not in (?)', stocklist.products.map(&:id))
    respond_to do |format|
      format.json { render :json => @products.to_json }
    end
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

end
