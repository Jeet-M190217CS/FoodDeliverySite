class Restaurant < ApplicationRecord
  belongs_to :user
  has_one :address, as: :parent_ref
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
end
