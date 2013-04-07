class StocklistController < ApplicationController

  def index 
    @stocklist = Stock.all
    render :json => @stocklist
  end

  def show
    @stocklist = Stock.find(params[:id], :include => :product_stocks )
    @stocklist.product_stocks.each do |sl|
      sl.quantity = !sl.quantity ? 0 : sl.quantity
    end
    render :json => @stocklist.to_json( :include =>  { :product_stocks => { :include => :product } } )
  end

  def add
    stocklist = Stock.find(params[:id])
    product = Product.find(params[:product_id])
    if (stocklist && product)
      if stocklist.products.push product
        respond_to do |format|
          format.json { head :ok }
        end
      end
    end 
  end

  def remove
    stocklist = Stock.find(params[:id])
    product = Product.find(params[:product_id])

    stocklist.products.delete(product)

    respond_to do |format|
       format.json { head :ok }
    end
  end



end
