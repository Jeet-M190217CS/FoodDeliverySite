class RemoveColumnFromAddresses < ActiveRecord::Migration[6.0]
  def change

    remove_column :addresses, :addr_ref_id_type, :string
  end
end
