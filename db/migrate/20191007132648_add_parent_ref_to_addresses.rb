class AddParentRefToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_reference :addresses, :parent_ref, polymorphic: true
  end
end
