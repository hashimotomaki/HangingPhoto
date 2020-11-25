class Photo < ApplicationRecord
  belongs_to :user
  has_many :photo_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  has_many :bookmarks, dependent: :destroy
  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  attachment :image, destroy: false
  validates :image, presence: true
  validates :title, presence: true
	validates :body, presence: true, length: {maximum: 500}
end
