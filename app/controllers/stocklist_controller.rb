class StocklistController < ApplicationController

  def index 
    @stocklist = Stock.all
    respond_to do |format|
      format.json { render :json => @stocklist.to_json }
    end
  end

  def show
    @stocklist = Stock.find(params[:id], :include => :product_stocks )
    @stocklist.product_stocks.each do |sl|
      sl.quantity = !sl.quantity ? 0 : sl.quantity
    end
    respond_to do |format|
      format.json { render :json => @stocklist.to_json( :include =>  
            { :product_stocks => { :include => :product } } ) }
    end
  end

end
