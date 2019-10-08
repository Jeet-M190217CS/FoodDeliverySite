class Address < ApplicationRecord
    belongs_to :parent_ref, polymorphic: true, optional: true

    validates :street, presence: true,length: { minimum:1 }
    validates :city, presence: true, length: { minimum:1 }
    validates :pincode, presence: true, length: { is:6 }, numericality: { only_integer:true }
    validates :state, presence: true, length: { minimum:1 }
end
