class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :commenters, through: :comments
  has_many :likes, as: :likeable

  validates :body, presence: true, length: { maximum: 500 }

  scope :for_page, ->(page, num_posts) { offset(page * num_posts).limit(num_posts) }
end
