class Merchant::DiscountsController < ApplicationController 
  def index 
    @discounts = set_merchant.discounts
  end 

private
  def set_merchant 
    @merchant = Merchant.find(params[:merchant_id])
  end 
end 