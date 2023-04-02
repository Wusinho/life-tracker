# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
password = '123456'
players = %w[zero vash wusinho terry retry volrath footman zambito]


players.each_with_index do |player, index|
  User.create(
    email: "user_#{index}@gmail.com",
    password: password,
    password_confirmation: password,
    nickname: player,
    online: false
  )
end