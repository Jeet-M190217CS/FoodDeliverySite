class User < ApplicationRecord
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    has_one :address, as: :parent_ref
    has_one :restaurant
    has_many :orders

    before_save {email.downcase!}
    validates :name, presence: true
    validates :phone, presence: true, length: { is: 10 }, numericality: { only_integer:true }
    validates :role, presence: true, length: { is: 1 }
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: EMAIL_REGEX},
                uniqueness: { case_sensitive:false } 
    has_secure_password
    validates :password, length:{ minimum:6 }, on:[:create], presence:true
end
