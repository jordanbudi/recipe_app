require 'yummly'

class Search
  attr_accessor :results

  def initialize
    Yummly.configure do |config|
      config.app_id = "4e9f2aa0"
      config.app_key = "e54e9cfa05d58b64bab7da2301f05c0b"
      config.use_ssl = true # Default is false
    end
  end

  def search(recipe)
    @results = Yummly.search(recipe).matches.sample # this returns an array of recipe results
  end

  def display_results
    first_recipe_name = @results["recipeName"]
    first_recipe_ingredients = @results["ingredients"] # this returns an array of recipe ingredients
    first_recipe_id = @results["id"]

    puts "--------------------------------"
    puts "Recipe name: #{first_recipe_name}"
    puts "Recipe ingredients: #{first_recipe_ingredients}"
    puts "Here is a link to the recipe: http://www.yummly.com/recipe/#{first_recipe_id}"
    puts "--------------------------------"
  end
end

searcher = Search.new
searcher.search('Pizza')
searcher.display_results
