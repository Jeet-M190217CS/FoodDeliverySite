class Address < ApplicationRecord
    belongs_to :parent_ref, polymorphic: true

    validates :street, presence: true
    validates :city, presence: true
    validates :pincode, presence: true, length: { is:6 }, numericality: { only_integer:true }
    validates :state, presence: true
end
