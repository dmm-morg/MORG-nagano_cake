class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  belongs_to :genre

  with_options presence: true do
    validates :name
    validates :introduction
    validates :tax_excluded_price
    validates :sales_status
    validates :genre_id
    validates :image
  end

  def tax_included_price
    (tax_excluded_price * 1.1).floor
  end

  enum sales_status: { sale: true, stop_selling: false }

end

