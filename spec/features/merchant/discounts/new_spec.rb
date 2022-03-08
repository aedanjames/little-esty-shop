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

end 