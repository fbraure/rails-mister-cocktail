# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "SEED CLEAR"
Ingredient.destroy_all
Cocktail.destroy_all
Dose.destroy_all
puts "SEED CREATE"

10.times do
  Cocktail.create!(
    name: Faker::Games::Heroes.name
  )
end

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
hash = JSON.parse(open(url).read)
hash["drinks"].each do |drink|
  Ingredient.create!(name: drink["strIngredient1"])
end
Ingredient.create!(name: "lemon")
Ingredient.create!(name: "ice")
Ingredient.create!(name: "mint leaves")

20.times do
  Dose.create(
    description: Faker::Name.name,
    cocktail: Cocktail.all.sample,
    ingredient: Ingredient.all.sample
  )
end

puts "SEED END"
