require 'open-uri'
require 'nokogiri'

puts "SEED CLEAR"
Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all
puts "SEED CREATE"
cocktails_url = "https://www.1001cocktails.com/"
cocktails_doc = open(cocktails_url).read
cocktails_html_doc = Nokogiri::HTML(cocktails_doc)
cocktails_html_doc.search('.recipe-card-link').each do |cocktails_element|
  # Card principal
  ingredients_url = cocktails_element.attributes["href"].value
  cocktail = Cocktail.new(
    name: cocktails_element.search(".recipe-card__title").text,
    image: cocktails_element.search("img").attribute("data-src").value
  )
  if cocktail.save!
    # liste des ingredients
    ingredients_doc = open(ingredients_url).read
    ingredients_html_doc = Nokogiri::HTML(ingredients_doc)
    ingredients_html_doc.search('.recipe-ingredients__list__item').each do |ingredient_element|
      quantity = ingredient_element.search(".recipe-ingredient-qt").text
      description = ingredient_element.search(".ingredient").text
      if description.index(" d'")
        quantity = "#{quantity} #{description.split(" d'")[0]}"
        description = description.split(" d'")[1..-1].join(" d'")
      elsif description.index(" de ")
        quantity = "#{quantity} #{description.split(" de ")[0]}"
        description = description.split(" de ")[1..-1].join(" de ")
      end
      quantity = "un peu" if quantity == ""
      ingredient = Ingredient.find_by_name(description) || Ingredient.new(name: description)
      if ingredient.save!
        dose = Dose.create!(
          description: quantity,
          ingredient: ingredient,
          cocktail: cocktail
        )
      end
    end
  end
end


# 10.times do
#   Cocktail.create!(
#     name: Faker::Games::Heroes.name
#   )
# end

# url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
# hash = JSON.parse(open(url).read)
# hash["drinks"].each do |drink|
#   Ingredient.create!(name: drink["strIngredient1"])
# end
# Ingredient.create!(name: "lemon")
# Ingredient.create!(name: "ice")
# Ingredient.create!(name: "mint leaves")

# 20.times do
#   Dose.create(
#     description: Faker::Name.name,
#     cocktail: Cocktail.all.sample,
#     ingredient: Ingredient.all.sample
#   )
# end

puts "SEED END"
