class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :strip_name, :down_case_email
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments, through: :posts
  has_many :accepted_requests, class_name: 'Friend', foreign_key: 'friend_id'
  has_many :friends, foreign_key: 'main_user_id'
  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: 'sender_id'
  has_many :received_requests, class_name: 'FriendRequest', foreign_key: 'receiver_id', dependent: :destroy
  has_many :likes

  validates :username, presence: true

  validates :username, length: { within: 2..50 }
  validates :bio, length: { maximum: 275 }
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  attr_accessor :username

  private

  def strip_name
    username&.strip!
  end

  def down_case_email
    email&.downcase!
  end
end
