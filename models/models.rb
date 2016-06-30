require 'net/http'
require 'json'
require 'rubygems'

# puts "What do you want to search?"
# searchTerm = gets.chomp
def recipe_search(food_type, included_ingredients, excluded_ingredients)
  @sample_request = "http://api.yummly.com/v1/api/recipes?_app_id=4e9f2aa0&_app_key=e54e9cfa05d58b64bab7da2301f05c0b&"

  if food_type.length > 1
    @sample_request = @sample_request + "&q=#{food_type}"
  end
# puts "What ingredients do you have in fridge (seperate ingredients with commas)"
# allowedIngredient = gets.chomp.gsub(", ",",").gsub(",","&allowedIngredient[]=")
  if included_ingredients.length > 1
    @sample_request = @sample_request + "&allowedIngredient[]=#{included_ingredients}"
  end
# puts "What ingredients DON\'T you want to use? (seperate ingredients with commas)"
# excludedIngredient = gets.chomp.gsub(", ",",").gsub(",","&excludedIngredient[]=")
  if excluded_ingredients.length > 1
    @sample_request = @sample_request + "&excludedIngredient[]=#{excluded_ingredients}"
  end
  get_result(@sample_request)
end

def get_result(req)
  sample_uri = URI(req)
  sample_response = Net::HTTP.get(sample_uri)
  sample_parsedResponse = JSON.parse(sample_response)

  results_array = []
  samples_value = sample_parsedResponse["matches"].sample
  results_array.push(samples_value["recipeName"])
  results_array.push(samples_value["ingredients"])
  results_array.push(((samples_value["totalTimeInSeconds"].to_i)/60).to_s+" minutes")
  results_array.push(samples_value["imageUrlsBySize"]["360"])
  results_array.push(samples_value["id"])
  return results_array
end





def new_recipe_api_call(recipe_id)
  @api_link ="http://api.yummly.com/v1/api/recipe/#{recipe_id}?_app_id=4e9f2aa0&_app_key=e54e9cfa05d58b64bab7da2301f05c0b"
  sample_uri = URI(@api_link)
  sample_response = Net::HTTP.get(sample_uri)
  sample_parsedResponse = JSON.parse(sample_response)
  @recipe_image_url = sample_parsedResponse["images"][0]["hostedLargeUrl"]
  @recipe_url = sample_parsedResponse["source"]["sourceRecipeUrl"]
  @recipe_ingredient_list = sample_parsedResponse["ingredientLines"]
  @recipe_servings = sample_parsedResponse["yield"]
  @recipe_rating = sample_parsedResponse["rating"]
  if sample_parsedResponse["nutritionEstimates"][0]["value"] == nil
    @recipe_calories = "calorie count unavailable"
  else
    @recipe_calories = sample_parsedResponse["nutritionEstimates"][0]["value"]
  end
end


# puts sample_parsedResponse["matches"].sample["recipeName"]
# puts sample_parsedResponse["matches"].sample["ingredients"]
# puts sample_parsedResponse["matches"].sample["totalTimeInSeconds"]/60+"minutes"
