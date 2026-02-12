class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, foreign_key: :user_id

  has_many :orders

  has_many :wishlists, dependent: :destroy
  has_many :wishlist_products, through: :wishlists, source: :product

  has_one :cart, dependent: :destroy

  has_many :messages, dependent: :destroy

end
