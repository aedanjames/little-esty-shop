require './app/models/api/holiday_search'
require './app/models/api/holiday_service'

class Merchant::DiscountsController < ApplicationController 
  def index 
    @merchant = set_merchant
    @upcoming_holidays = HolidaySearch.new
  end 

  def show 
    @discount = set_discount
  end

private
  def set_merchant 
    Merchant.find(params[:merchant_id])
  end 

  def set_discount
    Discount.find(params[:id])
  end 
end 