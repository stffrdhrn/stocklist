class ProductStockController < ApplicationController

  def quantity
    productStock = ProductStock.find(params[:id])

    if productStock.stock.user == current_user
      productStock.quantity = params[:quantity]
      productStock.save
      render :json => {:status => :ok}, :status => :ok
    else
      render :json => {:status => 'You have not rights to update this!'}, :status => :unauthorized
    end
  end

end
