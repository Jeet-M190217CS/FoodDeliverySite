class AddQuantityToOrderedItems < ActiveRecord::Migration[6.0]
  def change
    add_column :ordered_items, :quantity, :integer
  end
end
