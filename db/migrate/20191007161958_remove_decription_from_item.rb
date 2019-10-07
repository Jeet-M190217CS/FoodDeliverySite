class RemoveDecriptionFromItem < ActiveRecord::Migration[6.0]
  def change

    remove_column :items, :decription, :text
  end
end
