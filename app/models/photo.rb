class Photo < ApplicationRecord
  belongs_to :user
  has_many :photo_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  attachment :photo_image, destroy: false
  validates :title, presence: true
	validates :body, presence: true, length: {maximum: 500}
end
