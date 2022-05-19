class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  validates :total_count, numericality:{ only_integer: true }

  def subtotal
    item.tax_included_price * total_count
  end

end

