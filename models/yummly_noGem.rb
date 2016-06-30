require 'net/http'
require 'json'
require 'rubygems'

sample_request = "http://api.yummly.com/v1/api/recipes?_app_id=4e9f2aa0&_app_key=e54e9cfa05d58b64bab7da2301f05c0b&"

puts "What do you want to search?"
searchTerm = gets.chomp
if searchTerm.length > 1
  sample_request = sample_request + "&q=#{searchTerm}"
end
puts "What ingredients do you have in fridge (seperate ingredients with commas)"
allowedIngredient = gets.chomp.gsub(", ",",").gsub(",","&allowedIngredient[]=")
if allowedIngredient.length > 1
  sample_request = sample_request + "&allowedIngredient[]=#{allowedIngredient}"
end
puts "What ingredients DON\'T you want to use? (seperate ingredients with commas)"
excludedIngredient = gets.chomp.gsub(", ",",").gsub(",","&excludedIngredient[]=")
if excludedIngredient.length > 1
  sample_request = sample_request + "&excludedIngredient[]=#{excludedIngredient}"
end

sample_uri = URI(sample_request)
sample_response = Net::HTTP.get(sample_uri)
sample_parsedResponse = JSON.parse(sample_response)

puts sample_parsedResponse["matches"].sample["recipeName"]
puts sample_parsedResponse["matches"].sample["ingredients"]
puts sample_parsedResponse["matches"].sample["totalTimeInSeconds"]/60+"minutes"
