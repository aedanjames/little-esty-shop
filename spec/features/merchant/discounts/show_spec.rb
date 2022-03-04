require 'rails_helper'

RSpec.describe 'The Merchant Discounts Index' do 
  before :each do 
    @merchant = Merchant.create!(name: 'Stranger')
    @merchant2 = Merchant.create!(name: 'Nope')
    @discount1 = @merchant.discounts.create!(name: 'five', threshold: 5, percentage: 20)
    @discount2 = @merchant.discounts.create!(name: 'ten', threshold: 10, percentage: 30)
  end
 
  it 'shows a discounts threshold and percentage' do 
    visit merchant_discount_path(@merchant.id, @discount1.id)
    within '#attributes' do 
      expect(page).to have_content(@discount1.threshold)
      expect(page).to have_content(@discount1.percentage)
    end 
  end 
end 