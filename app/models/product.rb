class Product < ApplicationRecord
    has_one_attached :image
    has_many :order_items, dependent: :destroy
    has_many :orders
  

    def self.ransackable_attributes(auth_object = nil)
      [
        "id",
        "name",
        "price",
        "description",
        "active",
        "created_at",
        "updated_at"
      ]
    end
  
    def self.ransackable_associations(auth_object = nil)
      []
  end
end
  