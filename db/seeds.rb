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
user1 = User.create(name: "Joel", email: "joel@example.com", phone: "123456789", password: "contraseña1", role: 1)
user2 = User.create(name: "Diego", email: "diego@example.com", phone: "987654321", password: "contraseña2", role: 2)
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

data = {
  prop1: { photos: ['img01.jpg', 'img02.jpg', 'img03.jpg'] },
  prop2: { photos: ['img04.jpg', 'img05.jpg', 'img06.jpg'] },
  prop3: { photos: ['img07.jpg', 'img08.jpg', 'img09.jpg'] },
  prop4: { photos: ['img10.jpg', 'img11.jpg', 'img12.jpg'] },
  prop5: { photos: ['img13.jpg', 'img14.jpg', 'img15.jpg'] },
  prop6: { photos: ['img16.jpg', 'img17.jpg', 'img18.jpg'] },
  prop7: { photos: ['img19.jpg', 'img20.jpg', 'img01.jpg'] },
  prop8: { photos: ['img02.jpg', 'img03.jpg', 'img04.jpg'] }
}


property1 = Property.create(
  operation: "Venta", address: "Calle 123, Ciudad A",category:"Department", price: 250000, maintenance: 200, pets: true, bedrooms: 3, bathrooms: 2, area: 150, description: "Hermosa casa en venta con amplio jardín.")

property2 = Property.create(
  operation: "Renta", address: "Avenida XYZ, Ciudad B",category:"Home", price: 1200, maintenance: 100, pets: false, bedrooms: 2,  bathrooms: 1, area: 80, description: "Apartamento en renta cerca del centro comercial.")

property3 = Property.create(
  operation: "Venta", address: "Calle Principal, Ciudad C", category:"Home",price: 180000, maintenance: 150, pets: true, bedrooms: 4, bathrooms: 3, area: 200, description: "Casa en venta con piscina y vista al mar.")

property4 = Property.create(
  operation: "Renta", address: "Avenida Central, Ciudad D", category:"Home",price: 900, maintenance: 80, pets: false, bedrooms: 1, bathrooms: 1, area: 60, description: "Estudio en renta amueblado en zona céntrica.")

property5 = Property.create(
  operation: "Venta", address: "Calle 456, Ciudad A", category:"Department",price: 300000, maintenance: 250, pets: true, bedrooms: 5, bathrooms: 4, area: 300, description: "Gran casa de lujo en venta con piscina y jardín.")

property6 = Property.create(
  operation: "Renta", address: "Avenida YZX, Ciudad B",category:"Department", price: 1600, maintenance: 120, pets: false, bedrooms: 3, bathrooms: 2, area: 120, description: "Casa en renta con amplio patio y cochera.")

property7 = Property.create(
  operation: "Venta", address: "Calle Secundaria, Ciudad C", category:"Home",price: 210000, maintenance: 180, pets: true, bedrooms: 4, bathrooms: 3, area: 220, description: "Casa en venta con acabados de primera calidad.")

property8 = Property.create(
  operation: "Renta", address: "Avenida Periférica, Ciudad D", category:"Department",price: 1100, maintenance: 90, pets: false, bedrooms: 2, bathrooms: 1, area: 90, description: "Departamento en renta con vista panorámica.")

attach_local_photos(property1, data[:prop1][:photos])
attach_local_photos(property2, data[:prop2][:photos])
attach_local_photos(property3, data[:prop3][:photos])
attach_local_photos(property4, data[:prop4][:photos])
attach_local_photos(property5, data[:prop5][:photos])
attach_local_photos(property6, data[:prop6][:photos])
attach_local_photos(property7, data[:prop7][:photos])
attach_local_photos(property8, data[:prop8][:photos])

puts "Seeding user_properties"
users = User.all

users.each do |user|
  n = rand(3..6)
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