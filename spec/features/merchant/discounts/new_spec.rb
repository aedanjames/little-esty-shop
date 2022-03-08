require 'rails_helper'

RSpec.describe 'The Merchant Discounts Index' do 
  before :each do 
    @merchant = Merchant.create!(name: 'Stranger')
    @merchant2 = Merchant.create!(name: 'Nope')
    @discount1 = @merchant.discounts.create!(name: 'five', threshold: 5, percentage: 20)
    @discount2 = @merchant.discounts.create!(name: 'ten', threshold: 10, percentage: 30)
    @discount3 = @merchant.discounts.create!(name: 'three', threshold: 3, percentage: 10)
    @discount4 = @merchant2.discounts.create!(name: 'nope', threshold: 3, percentage: 10)
  end

  it 'has a form that allows a user to create a new discount' do 
    visit new_merchant_discount_path(@merchant.id)
    fill_in 'Name', with: "twofer"
    fill_in 'Threshold', with: "2"
    fill_in 'Percentage', with: "50"
    click_button('Create Discount')

    expect(current_path).to eq(merchant_discounts_path(@merchant.id))
    expect(page).to have_content("Discount Created")
  end 

  it 'will not allow a user to create a discount with percentage greater than 100' do 
    visit new_merchant_discount_path(@merchant.id)
    fill_in 'Name', with: "twofer"
    fill_in 'Threshold', with: "2"
    fill_in 'Percentage', with: "101"
    click_button('Create Discount')
    expect(current_path).to eq(new_merchant_discount_path(@merchant.id))
    expect(page).to have_content("Discount creation failed. Ensure all fields are completed and percentage is not greater than 100%")
  end 

  it 'will not allow a user to create a discount with a threshold < 1' do 
    visit new_merchant_discount_path(@merchant.id)
    fill_in 'Name', with: "twofer"
    fill_in 'Threshold', with: "-2"
    fill_in 'Percentage', with: "99"
    click_button('Create Discount')
    expect(current_path).to eq(new_merchant_discount_path(@merchant.id))
    expect(page).to have_content("Discount creation failed. Ensure all fields are completed and percentage is not greater than 100%")
  end 

  it 'will not allow the user to submit an incomplete form' do 
    visit new_merchant_discount_path(@merchant.id)
    fill_in 'Name', with: ""
    fill_in 'Threshold', with: "2"
    fill_in 'Percentage', with: "10"
    click_button('Create Discount')
    expect(current_path).to eq(new_merchant_discount_path(@merchant.id))
    expect(page).to have_content("Discount creation failed. Ensure all fields are completed and percentage is not greater than 100%")
  end 
end 