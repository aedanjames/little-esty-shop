class Merchant::DiscountsController < ApplicationController 
  def index 
    @merchant = set_merchant
  end 

private
  def set_merchant 
    @merchant = Merchant.find(params[:merchant_id])
  end 
end 