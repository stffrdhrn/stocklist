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

end
