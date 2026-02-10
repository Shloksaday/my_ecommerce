class Product < ApplicationRecord
  belongs_to :category

  has_one_attached :image

  has_many :wishlists, dependent: :destroy


  def self.ransackable_attributes(auth_object = nil)
    %w[id name description price stock category_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category image_attachment image_blob]
  end
end
