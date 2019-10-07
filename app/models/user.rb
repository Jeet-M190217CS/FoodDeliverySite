class User < ApplicationRecord
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    before_save {email.downcase!}
    validates :name, presence: true
    validates :phone, presence: true, length: { is: 10 }, numericality: { only_integer:true }
    validates :role, presence: true, length: { is: 1 }
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: EMAIL_REGEX},
                uniqueness: { case_sensitive:false } 
    has_secure_password
    validates :password, length:{ minimum:6 }, on:[:create, :update], presence:true
end
