# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
    app = App.create({
        name: Faker::Name.name,
        chats_count: 1,
    })
    
    chat = Chat.create({
        app_id: app.token,
        number: 1,
        message_count: 0
        })
    puts chat
    puts chat.errors
end