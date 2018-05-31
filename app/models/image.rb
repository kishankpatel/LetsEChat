class Image < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", large: "600x600>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :imageable, polymorphic: true
end
