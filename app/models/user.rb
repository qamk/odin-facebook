class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments, through: :posts
  has_many :accepted_requests, class_name: 'Friend', foreign_key: 'main_user_id'
  has_many :friends, foreign_key: 'friend_id'
  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: 'sender_id'
  has_many :received_requests, class_name: 'FriendRequest', foreign_key: 'receiver_id'
  has_many :likes
end
