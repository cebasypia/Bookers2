class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true
end
