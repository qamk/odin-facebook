class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  validates :likeable_id, uniqueness: { scope: %i[user likeable_type] }
  validates :likeable_type, presence: true # Stops a record from being saved with a blank type (i.e. useless record)
end
