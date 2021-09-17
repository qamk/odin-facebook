class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :commenters, through: :comments
  has_many :likes, as: :likeable

  validates :body, presence: true, length: { maximum: 500 }
end
