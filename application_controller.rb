require 'bundler'
require_relative 'models/models.rb'
Bundler.require

class ApplicationController < Sinatra::Base

  get '/' do
    @title = "Homepage"
    erb :index
  end

  post '/reciperesults' do
    food_type = params[:food_type].downcase
    included_ingredients = params[:included_ingredients].downcase
    excluded_ingredients = params[:excluded_ingredients].downcase
    @reciperesults_array = recipe_search(food_type, included_ingredients, excluded_ingredients)
    new_recipe_api_call(@reciperesults_array[0])
    # @recipe_api = recipe_link(new_recipe_api_call)
    erb :results
  end

end
