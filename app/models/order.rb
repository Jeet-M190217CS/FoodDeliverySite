class Order < ApplicationRecord
  include PusherHelper

  belongs_to :user
  belongs_to :restaurant
  has_many :ordered_items

  validates :status, length: {is:1}

  after_create :send_data_to_admin

  private

  def send_data_to_admin
    get_channels_client.trigger('order','new-order',self)
  end
end
