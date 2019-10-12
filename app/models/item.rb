class Item < ApplicationRecord
    belongs_to :restaurant
    has_one_attached :image

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
