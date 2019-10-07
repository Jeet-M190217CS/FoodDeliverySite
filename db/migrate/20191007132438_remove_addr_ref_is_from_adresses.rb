class RemoveAddrRefIsFromAdresses < ActiveRecord::Migration[6.0]
  def change
    remove_reference :addresses, :addr_ref_id
  end
end
