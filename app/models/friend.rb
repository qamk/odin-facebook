class Friend < ApplicationRecord
  belongs_to :main_user, class_name: 'User'
  belongs_to :friend, class_name: 'User'
end
