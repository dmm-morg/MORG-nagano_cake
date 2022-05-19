class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  
  with_options presence: true do
    validate :name
    validate :introduction
    validate :tax_excluded_price
    validate :sales_status
    validate :genre_id
    validate :image
  end

  def tax_included_price
    (tax_excluded_price * 1.1).floor
  end
  
  enum sales_status: { sale: true, stop_selling: false }
  
end
