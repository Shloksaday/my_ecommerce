class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true

  enum :status, {
    pending: "pending",
    paid: "paid",
    failed: "failed"
  }
end
