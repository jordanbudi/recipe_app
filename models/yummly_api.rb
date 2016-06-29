# this creates a new connection to the Yummly API
# it should go in an initialize method in your new model/class
Yummly.configure do |config|
  config.app_id = "4e9f2aa0"
  config.app_key = "e54e9cfa05d58b64bab7da2301f05c0b"
  config.use_ssl = true # Default is false
end

# this searches Yummly for a recipe and returns an array of recipe objects
# this should go into a method within your new model/class
results = Yummly.search('type of recipe you want') #=> an array of recipe results

puts "Are you making breakfast, lunch, or dinner?"
type = gets.chomp

def recipe(type)
