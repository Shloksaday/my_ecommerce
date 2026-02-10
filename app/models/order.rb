class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true

  belongs_to :user
  has_many :cart_items, dependent: :destroy

  validates :total_price, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      total_price
      status
      created_at
      user_id
      product_id
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[
      user
      product
    ]
  end

  enum :status, {
    pending: "pending",
    paid: "paid",
    failed: "failed"
  }
end
