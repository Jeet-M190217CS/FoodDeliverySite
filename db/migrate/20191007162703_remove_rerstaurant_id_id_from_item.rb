class RemoveRerstaurantIdIdFromItem < ActiveRecord::Migration[6.0]
  def change

    remove_column :items, :restaurant_id_id, :integer
  end
end
