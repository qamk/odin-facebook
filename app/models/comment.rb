class Comment < ApplicationRecord
  belongs_to :commenter, class_name: 'User'
  belongs_to :post
  has_many :likes, as: :likeable
end
