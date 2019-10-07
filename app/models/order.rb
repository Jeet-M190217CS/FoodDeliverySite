class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :ordered_items

  validates :status, length: {is:1}
end
