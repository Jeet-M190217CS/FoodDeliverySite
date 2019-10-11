class User < ApplicationRecord
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    has_one :address, as: :parent_ref
    has_one :restaurant
    has_many :orders
    has_one_attached :image

    before_save {email.downcase!}
    validates :name, presence: true
    validates :phone, presence: true, length: { is: 10 }, numericality: { only_integer:true }
    validates :role, presence: true, length: { is: 1 }
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: EMAIL_REGEX},
                uniqueness: { case_sensitive:false } 
    has_secure_password
    validates :password, length:{ minimum:6 }, on:[:create], presence:true
    validate :image_type

    private
    def image_type
        if image.attached?
            if !image.content_type.in?(%('image/png image/jpeg'))
                errors.add(:image,"needs to be a jpg/jpeg or png!")
            end
        end
    end
end
