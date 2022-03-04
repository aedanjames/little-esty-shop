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
    expect(page).to have_no_content(@discount2.name)
  end 

  it 'has a link to bring the user to a form to edit the discount' do 
    visit merchant_discount_path(@merchant.id, @discount1.id)
    within '#edit' do 
    expect(page).to have_link("Edit #{@discount1.name}")
    expect(page).to have_no_link("Edit #{@discount2.name}")
    click_link("Edit #{@discount1.name}")
    expect(current_path).to eq("edit_merchant_discount_path(@merchant, @discount)")
    end 
  end 
end 