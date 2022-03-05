require 'rails_helper'

RSpec.describe 'The Merchant Discounts Index' do 
  before :each do 
    @merchant = Merchant.create!(name: 'Stranger')
    @merchant2 = Merchant.create!(name: 'Nope')
    @discount1 = @merchant.discounts.create!(name: 'five', threshold: 5, percentage: 20)
    @discount2 = @merchant.discounts.create!(name: 'ten', threshold: 10, percentage: 30)
  end

  it 'contains a pre-populated form' do 
    visit edit_merchant_discount_path(@merchant.id, @discount1.id)
    expect(find_field('Name').value).to eq(@discount1.name)
    expect(find_field('Threshold').value).to eq("5")
    expect(find_field('Percentage').value).to eq("20")
  end 
end