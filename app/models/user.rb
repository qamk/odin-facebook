class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  before_validation :strip_name, :down_case_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
  has_many :accepted_requests, class_name: 'Friend', foreign_key: 'friend_id', dependent: :destroy
  has_many :friends, foreign_key: 'main_user_id'
  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_requests, class_name: 'FriendRequest', foreign_key: 'receiver_id', dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :username, length: { within: 2..50 }, presence: true
  validates :bio, length: { maximum: 275 }
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  scope :list_users_in_id_collection, ->(id_collection) { where(id: id_collection) }
  scope :except_user, ->(user) { where.not(id: user.id) }
  scope :for_page, ->(page, num_users) { order(:username, :created_at).offset(num_users * page).limit(num_users) }

  # Return users according to query or return all users
  def self.search(query = nil)
    search_with = query || ''
    search_with = "%#{search_with}%"
    where("username LIKE ?", search_with)
  end

  private

  def strip_name
    username&.strip!
  end

  def down_case_email
    email&.downcase!
  end
end
