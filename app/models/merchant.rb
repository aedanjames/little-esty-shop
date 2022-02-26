class Merchant < ApplicationRecord
  enum status: {enabled: 0, disabled: 1}
  validates :name, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  scope :with_successful_transactions, -> { joins(:transactions)
            .where("transactions.result =?", 0)}

  def merchant_invoices
    (invoices.order(:id)).uniq
  end

  def enabled_status
    self.items.where("item_status =?", 1)
  end

  def disabled_status
    self.items.where("item_status =?", 2)
  end

  def five_most_popular_items
    items.joins(invoice_items: { invoice: :transactions })
    .where('transactions.result =?', 0)
    .select("items.*, invoice_items.item_id, sum(invoice_items.unit_price * invoice_items.quantity) AS total_item_sales")
    .group("invoice_items.item_id, items.id")
    .order(total_item_sales: :DESC)
    .limit(5)
  end

  def change_status
    if status == 'enabled'
      self.disabled!
      status
    elsif status == 'disabled'
      self.enabled!
      status
    end
  end

  def self.enabled_merchants
    where(status: :enabled)
  end

  def self.disabled_merchants
    where(status: :disabled)
  end

  def not_shipped
    invoice_items.where("status != 2")
  end

  def top_five_customers
    customers.with_successful_transactions
              .select("customers.*, count('transactions') AS transaction_count")
              .group("customers.id")
              .order("transaction_count DESC")
              .limit(5)
  end

  def self.top_five_merchants
    with_successful_transactions
    .joins(:invoice_items)
    .select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) AS total_revenue")
    .group("merchants.id")
    .order("total_revenue DESC")
    .limit(5)

  end
end
