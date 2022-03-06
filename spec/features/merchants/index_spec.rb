require 'rails_helper'

RSpec.describe 'The Merchants Index Page' do 

  before :each do 
    @merchant = Merchant.create!(name: 'The Duke')
    @merchant2 = Merchant.create!(name: 'The Fluke')
    @customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @customer2 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @invoice1 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 0, customer_id: @customer2.id)
    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'literal goop', description: 'delicious', unit_price: '4000', merchant_id: @merchant2.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 2000, status: 1)
    @invoice_item3 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 500, status: 1)
  end 
  it 'lists the name of each merchant' do 
    visit merchants_path
    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@merchant2.name)
  end 
end 