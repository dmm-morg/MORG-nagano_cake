class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  validates :post_code, length: { is: 7 }
  validates :name, :address, :post_code, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { wait_payment: 0, confirm_payment: 1, making: 2, preparing: 3, shipped: 4 }



end
