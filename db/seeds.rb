# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Destroying database"

UserProperty.destroy_all
User.destroy_all
Property.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('properties')
ActiveRecord::Base.connection.reset_pk_sequence!('user_properties')

puts "Seeding users"
user1 = User.create(name:"Joel")
user2 = User.create(name:"Diego")
user3 = User.create(name:"Oliver")
user4 = User.create(name:"Eduardo")

puts "Seeding properties"


def attach_local_photos(property, photo_names)
  photo_names.each do |photo_name|
    file_path = Rails.root.join('app', 'assets', 'images', 'seed_images', photo_name)
    file = File.open(file_path)
    property.photos.attach(io: file, filename: photo_name)
    file.close
  end
end

data = {photos: ['img01.jpg','img02.jpg']}
property1 = Property.create(address:"av. sth A")
attach_local_photos(property1, data[:photos])
# property2 = Property.create(address:"av. sth B")
# property3 = Property.create(address:"av. sth C")
# property4 = Property.create(address:"av. sth D")
# property5 = Property.create(address:"av. sth E")
# property6 = Property.create(address:"av. sth F")
# property7 = Property.create(address:"av. sth G")
# property8 = Property.create(address:"av. sth H")



puts "Seeding user_properties"
users = User.all

users.each do |user|
  n = rand(1..8)
  properties = Property.all.sample(n)
  properties.each do |property|
    user.user_properties.create(property: property)
  end
end

puts "Seed Ends..."