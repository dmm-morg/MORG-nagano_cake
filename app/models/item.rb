class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  def tax_included_price
    (tax_excluded_price * 1.1).floor
  end
  
end
