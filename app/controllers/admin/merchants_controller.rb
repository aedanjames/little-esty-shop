class Admin::MerchantsController < ApplicationController

  def index 
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update 
    if params[:trigger]
      merchant = set_merchant
      merchant.change_status
      redirect_to admin_merchants_path
    elsif merchant.name != params[:name]
      merchant = set_merchant
      merchant.update!(name: params[:name])
      redirect_to admin_merchant_path(merchant)
      flash[:notice] = "#{merchant.name} has been updated"
    else 
      redirect_to admin_merchant_path(merchant)
    end 
  end

  def new
  end 

private 

  def set_merchant 
    @merchant = Merchant.find(params[:id])
  end 
end