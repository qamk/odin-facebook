# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# def find_by_username(username)
#   User.find_by(username: username)
# end

# def random_email
#   "test_#{Random.rand(1000)}@email.com"
# end

# USERNAMES = %w[Just_Lady LokiButNotReally Hammer_Thyme HelWontHoldMe TwoEyedGeniouse]
# BIO = ['That\'s THE Lady to you.', 'Find me practising magic tricks ~',
#         'Nothing better than BASHING garlic', 'An undying adrenaline junkie', 'Looking at your future with both eyes !']
# USERNAME_BIO = USERNAMES.zip(BIO)
# PASSWORD = 'norsemytholo-G'

# USERNAME_BIO.each do |username, bio|
#   u = User.create do |user|
#     user.username = username
#     user.password = PASSWORD
#     user.email = random_email
#     user.bio = bio
#   end
  
# end

# users = { thor: find_by_username('Hammer_Thyme'), freyja: find_by_username('Just_Lady'),
#   odin: find_by_username('TwoEyedGeniouse'), hel: find_by_username('HelWontHoldMe'),
#   loki: find_by_username('LokiButNotReally')
# }

# Friend.create(main_user: users[:thor], friend: users[:odin])
# Friend.create(main_user: users[:thor], friend: users[:freyja])
# Friend.create(main_user: users[:odin], friend: users[:loki])
# Friend.create(main_user: users[:hel], friend: users[:loki])
# Friend.create(main_user: users[:freyja], friend: users[:hel])