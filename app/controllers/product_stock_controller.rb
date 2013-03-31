class ProductStockController < ApplicationController

  def quantity
    productStock = ProductStock.find(params[:id])
    productStock.quantity = params[:quantity]
    productStock.save

    respond_to do |format|
      format.json { head :ok }
    end

  end

end
