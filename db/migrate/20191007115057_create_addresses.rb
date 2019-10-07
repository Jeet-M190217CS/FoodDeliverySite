class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :pincode
      t.string :state

      t.timestamps
    end
  end
end
