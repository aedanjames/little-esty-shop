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
    expect(page).to have_no_content(@discount2.name)
    expect(find_field('Name').value).to eq(@discount1.name)
    expect(find_field('Threshold').value).to eq("5")
    expect(find_field('Percentage').value).to eq("20")
  end 

  it 'allows the user to update fields and submit changes' do 
    visit edit_merchant_discount_path(@merchant.id, @discount1.id)
    fill_in 'Name', with: "Twelve"
    fill_in 'Threshold', with: "2"
    fill_in 'Percentage', with: "12"
    click_button "Update Discount"
    expect(current_path).to eq(merchant_discount_path(@merchant.id, @discount1.id))
    expect(page).to have_content('Twelve')
    expect(page).to have_content('2')
    expect(page).to have_content('12')
    expect(page).to have_no_content('five')
  end 

  it 'returns an error message if form is missing field' do 
    visit edit_merchant_discount_path(@merchant.id, @discount1.id)
    fill_in 'Name', with: ""
    fill_in 'Threshold', with: "2"
    fill_in 'Percentage', with: "12"
    click_button "Update Discount"
    expect(current_path).to eq(merchant_discount_path(@merchant.id, @discount1.id))
    expect(page).to have_content('Discount Update Failed')
    
  end 
end