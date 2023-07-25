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
user1 = User.create(name: "Joel", email: "joel@example.com", phone: "123456789", password: "contraseña1", role: 1)#landlord
user2 = User.create(name: "Diego", email: "diego@example.com", phone: "987654321", password: "contraseña2", role: 2)#seeker
user3 = User.create(name: "Oliver", email: "oliver@example.com", phone: "555555555", password: "contraseña3", role: 1)
user4 = User.create(name: "Eduardo", email: "eduardo@example.com", phone: "777777777", password: "contraseña4", role: 2)

puts "Seeding properties"


def attach_local_photos(property, photo_names)
  photo_names.each do |photo_name|
    file_path = Rails.root.join('app', 'assets', 'images', 'seed_images', photo_name)
    file = File.open(file_path)
    property.photos.attach(io: file, filename: photo_name)
    file.close
  end
end

images = (1..20).map { |i| "img%02d.jpg" % i }

(1..40).each do |i|
  selected_images = images.sample(5)
  operation = ["Venta","Renta"].sample
  category = ["Department","Home"].sample
  property = Property.create(
    operation: operation, 
    address: "Calle #{i}, Ciudad #{('A'..'D').to_a.sample}",
    category: category,
    price: property == "Venta" ? rand(20000..50000) : rand(2000..5000), 
    maintenance: rand(50..300),
    pets: [true, false].sample,
    bedrooms: category == "Department" ? rand(1..3) : rand(2..6),
    bathrooms: category == "Department" ? rand(1..3) : rand(2..4),
    area: rand(50..400), 
    description: "Propiedad #{i} con descripción aleatoria.")
  attach_local_photos(property, selected_images)
end



puts "Seeding user_properties"
users = User.all

users.each do |user|
  n = rand(10..20)
  properties = Property.all.sample(n)
  properties.each do |property|
    active = [true, false].sample
    favorite = [true, false].sample
    contacted = [true, false].sample
    user.user_properties.create(
      property: property,
      active: active,
      favorite: favorite,
      contacted: contacted
    )
  end
end


puts "Seed Ends..."