class AddAddrRefIdToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_reference :addresses, :addr_ref_id, polymorphic: true
  end
end
