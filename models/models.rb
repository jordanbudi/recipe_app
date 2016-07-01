require 'net/http'
require 'json'
require 'rubygems'

def recipe_search(food_type, included_ingredients, excluded_ingredients)
  @sample_request = "http://api.yummly.com/v1/api/recipes?_app_id=4e9f2aa0&_app_key=e54e9cfa05d58b64bab7da2301f05c0b&"

  if food_type.length > 1
    @sample_request = @sample_request + "&q=#{food_type}"
  end

  if included_ingredients.length > 1
    array_of_included_ingredients = included_ingredients.gsub(", " , ",").split(",")
    array_of_included_ingredients.each do |included_ingredients|
      @sample_request = @sample_request + "&allowedIngredient[]=#{included_ingredients}"
    end
  end

  if excluded_ingredients.length > 1
    array_of_excluded_ingredients = excluded_ingredients.gsub(", " , ",").split(",")
    array_of_excluded_ingredients.each do |excluded_ingredients|
      @sample_request = @sample_request + "&excludedIngredient[]=#{excluded_ingredients}"
    end
  end

  get_result(@sample_request)
end

def get_result(req)
  sample_uri = URI(req)
  sample_response = Net::HTTP.get(sample_uri)
  sample_parsedResponse = JSON.parse(sample_response)

  results_array = []

  samples_value = sample_parsedResponse["matches"].sample
  results_array.push(samples_value["id"])
  results_array.push(samples_value["recipeName"])
  results_array.push(samples_value["ingredients"])
  results_array.push(((samples_value["totalTimeInSeconds"].to_i)/60).to_s+" minutes")
  if  samples_value.key?("imageUrlsBySize")
    results_array.push(samples_value["imageUrlsBySize"]["90"])
  else
    results_array.push("https://www2.tulane.edu/liberal-arts/anthropology/images/not_available_big.jpg")
  end
  return results_array
end

def new_recipe_api_call(recipe_id)
  @api_link ="http://api.yummly.com/v1/api/recipe/#{recipe_id}?_app_id=4e9f2aa0&_app_key=e54e9cfa05d58b64bab7da2301f05c0b"
  sample_uri = URI(@api_link)
  sample_response = Net::HTTP.get(sample_uri)
  sample_parsedResponse = JSON.parse(sample_response)
  if sample_parsedResponse["images"][0].key?("hostedLargeUrl")
    @recipe_image_url = sample_parsedResponse["images"][0]["hostedLargeUrl"]
  else
    @recipe_image_url = "images/photo_na.jpg"
  end
  @recipe_url = sample_parsedResponse["source"]["sourceRecipeUrl"]
  @recipe_ingredient_list = sample_parsedResponse["ingredientLines"]
  @recipe_servings = sample_parsedResponse["yield"]
  @recipe_rating = sample_parsedResponse["rating"]
  if sample_parsedResponse["nutritionEstimates"].length == 0
    @recipe_calories = "calorie count unavailable"
  else
    @recipe_calories = sample_parsedResponse["nutritionEstimates"][0]["value"]
  end
end


# Code below is used to test in terminal, uncomment then run in terminal to check that it works (for debugging)
# puts "What do you want to search?"
# searchTerm = gets.chomp
# puts "What ingredients do you have in fridge (seperate ingredients with commas)"
# allowedIngredient = gets.chomp.gsub(", ",",").gsub(",","&allowedIngredient[]=")
# puts "What ingredients DON\'T you want to use? (seperate ingredients with commas)"
# excludedIngredient = gets.chomp.gsub(", ",",").gsub(",","&excludedIngredient[]=")
#
# puts recipe_search(searchTerm, allowedIngredient, excludedIngredient)
