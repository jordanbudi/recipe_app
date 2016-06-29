

### Yummly

[Yummly](https://www.yummly.com/) is a great website for finding recipes.

We will be using the [Yummly Ruby gem](https://github.com/twmills/yummly) to connect to Yummly's API to search for recipes.

First, you need to install the Yummly gem on your computer. In terminal, from any directory, enter `gem install yummly`

Next, you will need to follow the instructions below to set up your app:

### Setup

Paste this into your `Gemfile`:
``` ruby
gem 'yummly'
```

### Searching for recipes

The rest of the code below should go into a model (in the models directory) of your application. Then you'll need to create a new instance of that class inside of a route in your application controller and call your methods there.

``` ruby
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
```

Check out `yummly_test.rb` to see how you can pull out the name, ingredients and link to the first recipe in the array. To test the Flatiron Yummly account and see the results in that file, fork and clone this lab then run `ruby yummly_test.rb` in your terminal.


<p data-visibility='hidden'>View <a href='https://learn.co/lessons/hs-yummly-api' title='Yummly'>Yummly</a> on Learn.co and start learning to code for free.</p>
