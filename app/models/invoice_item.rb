class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, packaged: 1, shipped: 2 }
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :discounts, through: :merchants

  def get_name_from_invoice
    item.name
  end

  def display_price
    cents = self.unit_price
    '%.2f' % (cents / 100.0)
  end

  def full_revenue
    ((unit_price * quantity)/100).round
  end 

  def return_discount
    item.merchant.discounts
    .where('discounts.threshold <= ?', quantity)
    .order(percentage: :desc)
    .first
  end 

  def discounted_revenue 

  end
end
