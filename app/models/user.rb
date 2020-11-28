class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :photos
  attachment :profile_image, destroy: false

  has_many :photos
  has_many :photo_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  has_many :following, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy # 自分がフォローしているユーザー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォローされているユーザー取得
  has_many :following_user, through: :followed, source: :following # 自分がフォローしている人
  has_many :followed_user, through: :following, source: :followed # 自分をフォローしている人

  has_many :photos, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_photos, through: :bookmarks, source: :photo
  def own_photo?(photo)
    self.id == photo.user_id
  end

    # ユーザーをフォローする
  def follow(user_id)
    follower.create!(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following_by?(user)
    following_user.find_by(id: user.id).present?
  end

  validates :name, presence: true
  validates :email, presence: true
  validates :introduction, length: {maximum: 100 }
end
