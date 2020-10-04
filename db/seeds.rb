# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

hammock = Raffle.create(product_name: 'ENO Lightweight Camping Hammock, 1 to 2 person', product_description: 'A hammock.', product_image: 'https://images-na.ssl-images-amazon.com/images/I/51JpumxVnRL._AC_.jpg', category: "Sports & Outdoor", number_of_ticket_slots: '80')
spatula = Raffle.create(product_name: 'Vollrath Black Nylon High-Heat Slotted Turner - 13 1/2 inch L', product_description: 'A spatula.', product_image: 'https://dijf55il5e0d1.cloudfront.net/images/na/5/3/1/53140_1000.jpg', category: "Kitchen", number_of_ticket_slots: '10')
sponge = Raffle.create(product_name: "SpongeBob SquarePants, Stretchpants Figure, Stretchable, +30 Wacky Sounds", product_description: "Sponge.", product_image: 'https://images-na.ssl-images-amazon.com/images/I/61QpWKZnOwL._AC_SX679_.jpg', category: "Toys", number_of_ticket_slots: '25' )