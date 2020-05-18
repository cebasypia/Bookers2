class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book
  has_many :book_comments, dependent: :destroy

  attachment :profile_image, destroy: false

  validates :name, length: { maximum: 20, minimum: 2 }
  validates :introduction, length: { maximum: 50 }

  def already_favorite?(book)
    favorites.exists?(book_id: book.id)
  end
end
