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

addresses = [
  "Av. Arequipa 123, San Isidro, Lima",
  "Jr. Camaná 456, Cercado de Lima, Lima",
  "Calle Las Begonias 789, San Borja, Lima",
  "Av. La Molina 321, La Molina, Lima",
  "Av. Brasil 987, Pueblo Libre, Lima",
  "Jr. Los Jazmines 654, Lince, Lima",
  "Av. Los Próceres 159, San Juan de Lurigancho, Lima",
  "Calle Los Cedros 753, Surco, Lima",
  "Av. Los Constructores 852, Ate, Lima",
  "Jr. Los Nogales 456, Magdalena del Mar, Lima",
  "Av. Javier Prado Este 753, San Isidro, Lima",
  "Jr. De la Unión 951, Cercado de Lima, Lima",
  "Calle Los Rosales 456, San Borja, Lima",
  "Av. Flora Tristán 852, La Molina, Lima",
  "Av. La Marina 159, Pueblo Libre, Lima",
  "Jr. Los Sauces 357, Lince, Lima",
  "Av. Los Álamos 753, San Juan de Lurigancho, Lima",
  "Calle Los Girasoles 852, Surco, Lima",
  "Av. Los Alcázares 456, Ate, Lima",
  "Jr. Los Nísperos 159, Magdalena del Mar, Lima",
  "Av. Salaverry 753, Jesús María, Lima",
  "Jr. De la Unión 951, Breña, Lima",
  "Calle Los Claveles 456, San Miguel, Lima",
  "Av. Petit Thouars 852, Lince, Lima",
  "Av. Huáscar 159, El Agustino, Lima",
  "Jr. Los Cipreses 357, San Juan de Miraflores, Lima",
  "Av. Los Rosales 753, Chorrillos, Lima",
  "Calle Los Ficus 852, San Juan de Lurigancho, Lima",
  "Av. Los Robles 456, San Borja, Lima",
  "Jr. Las Orquídeas 159, Surco, Lima",
  "Av. Los Naranjos 753, Santa Anita, Lima",
  "Jr. Los Pinos 951, Cercado de Lima, Lima",
  "Calle Los Lirios 456, Barranco, Lima",
  "Av. Santa Cruz 852, Santiago de Surco, Lima",
  "Av. Los Laureles 159, La Victoria, Lima",
  "Jr. Los Jardines 357, Chorrillos, Lima",
  "Av. Los Claveles 753, Miraflores, Lima",
  "Calle Los Tulipanes 852, San Juan de Lurigancho, Lima",
  "Av. Los Eucaliptos 456, Callao, Lima",
  "Jr. Las Azucenas 159, San Isidro, Lima"
]

(1..40).each do |i|
  selected_images = images.sample(5)
  operation = ["Venta","Renta"].sample
  category = ["Department","Home"].sample
  property = Property.create(
    operation: operation, 
    address: addresses[i-1],
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
  if user.role == 1
    n = rand(4..8)
  else
    n = 40
  end
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