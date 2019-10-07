class AddRestaurantIdToItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :restaurant, null: false, foreign_key: true
  end
end
