require 'rails_helper'

RSpec.describe 'The Merchant Invoice Show Page' do 
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

  it 'displays all information related to that invoice' do 
    visit merchant_invoice_path(@merchant.id, @invoice1.id)
    expect(page).to have_content("Merchant Invoice #{@invoice1.id} Show Page")
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.format_created_at(@invoice1.created_at))
    expect(page).to have_content(@invoice1.customer_name)
    expect(page).to have_no_content(@invoice2.id)
  end 

  it 'displays the total revenue that will be generated from all items on the invoice' do 
    visit merchant_invoice_path(@merchant.id, @invoice1.id)
    expect(page).to have_content(@invoice1.invoice_revenue)
    within(".total_revenue") do
      expect(page).to have_no_content(@invoice2.invoice_revenue)
    end
  end 

  it 'displays status as a select field that can update the items status' do 
    visit merchant_invoice_path(@merchant.id, @invoice1.id)
    expect(page).to have_content(@invoice_item1.status)
    expect(@invoice_item1.status).to eq("packaged")
    within("div#id-#{@invoice_item1.id}") do
      expect(page).to have_button("Update Item Status")
      select "shipped", :from => "status"
      click_button("Update Item Status")
      @invoice_item1.reload
      expect(page).to have_content ("shipped")
    end
    expect(page).to have_content ("Item Status Has Been Updated!")
  end 

  it 'shows the total discounted revenue from an invoice' do 
    discount1 = @merchant.discounts.create!(name: 'two', threshold: 2, percentage: 20)
    discount2 = @merchant.discounts.create!(name: 'smaller two', threshold: 2, percentage: 15)
    discount3 = @merchant.discounts.create!(name: 'ten', threshold: 10, percentage: 30)
    visit merchant_invoice_path(@merchant.id, @invoice1.id)
    within '.total_discounted_revenue' do 
      expect(page).to have_content(33.6)
    end 
    expect(page).to have_no_content(@invoice2.discounted_invoice_revenue)
  end 

  it 'has a link next to each invoice_item that brings the user to the discount show page if a discount exists for that invoice item' do 
    discount1 = @merchant.discounts.create!(name: 'two', threshold: 2, percentage: 20)
    discount2 = @merchant.discounts.create!(name: 'smaller two', threshold: 2, percentage: 15)
    discount3 = @merchant.discounts.create!(name: 'ten', threshold: 10, percentage: 30)
    visit merchant_invoice_path(@merchant.id, @invoice1.id)
    within "div#id-#{@invoice_item1.id}" do 
      expect(page).to have_link(discount1.name)
      click_link(discount1.name)
      expect(current_path).to eq(merchant_discount_path(@merchant.id, discount1.id))
    end
    expect(page).to have_no_link(discount2.name)
    expect(page).to have_no_link(discount3.name)
  end 
end