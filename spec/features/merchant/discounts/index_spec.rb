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

  it 'shows all of a merchants discounts including threshold and percentage' do 
    visit merchant_discounts_path(@merchant.id)
    expect(page).to have_content(@merchant.name)
    expect(page).to have_no_content(@merchant2.name)
    within '#five' do 
      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount1.threshold)
      expect(page).to have_content(@discount1.percentage)
    end 
    within '#ten' do 
      expect(page).to have_content(@discount2.name)
      expect(page).to have_content(@discount2.threshold)
      expect(page).to have_content(@discount2.percentage)
    end
    within '#three' do  
      expect(page).to have_content(@discount3.name)
      expect(page).to have_content(@discount3.threshold)
      expect(page).to have_content(@discount3.percentage)
    end 
    expect(page).to have_no_content(@discount4.name)
  end

  it 'has a link that brings the user to the discount show page' do 
    visit merchant_discounts_path(@merchant.id)
    within '#five' do 
      expect(page).to have_link(@discount1.name)
      click_link(@discount1.name)
      expect(current_path).to eq(merchant_discount_path(@merchant1.id, @discount1.id))
    end 
  end
end