require './app/models/api/holiday_search'
require './app/models/api/holiday_service'

class Merchant::DiscountsController < ApplicationController 
  def index 
    @merchant = set_merchant
    @upcoming_holidays = HolidaySearch.new
  end 

  def show 
    @merchant = set_merchant
    @discount = set_discount
  end

  def edit 
    @merchant = set_merchant 
    @discount = set_discount
  end 

  def update 
    discount = set_discount
    merchant = set_merchant
    if discount.update(discount_params)
      redirect_to merchant_discount_path(merchant.id, discount.id), flash: {notice: "Discount Successfully Updated"}
    else 
      redirect_to merchant_discount_path(merchant.id, discount.id), flash: {notice: "Discount Update Failed"}
    end 
  end

  def new 
    @merchant = set_merchant
    @discount = Discount.new
  end 

  def create 
    merchant = set_merchant
    discount = merchant.discounts.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(merchant.id), flash: {notice: "Discount Created" }
    else 
      redirect_to new_merchant_discount_path(merchant.id), flash: {notice: "Discount creation failed. Ensure all fields are completed." }
    end 
  end

  def destroy
    merchant = set_merchant
    discount = set_discount
    discount.delete
    redirect_to merchant_discounts_path(merchant.id)
  end 

private
  def set_merchant 
    Merchant.find(params[:merchant_id])
  end 

  def set_discount
    Discount.find(params[:id])
  end 

  def discount_params 
    params.require(:discount).permit(:name, :threshold, :percentage, :merchant_id)
  end 
end 