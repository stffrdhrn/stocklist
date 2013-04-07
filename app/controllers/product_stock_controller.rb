class ProductStockController < ApplicationController

  def quantity
    productStock = ProductStock.find(params[:id])
    productStock.quantity = params[:quantity]
    productStock.save

    render :json => {:status => :ok}, :status => :ok
  end

end
