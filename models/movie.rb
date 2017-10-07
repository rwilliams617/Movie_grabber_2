require 'active_model'
require 'pry'

class Movie
	include ActiveModel::Model
	include HTTParty

	#info from MovieTMDB.com needed to access their DB
	self.base_uri('api.themoviedb.org/3')
	API_KEY = 'fbc61f825a968137fd84a4e21c7a3964' 

	attr_accessor :id, :title, :year, :rating, :synopsis, :image_url

	def self.search(name)
		
		# Ask MovieDB API about the movie called name 
		result = get('/search/movie', { query: { query: name, api_key: API_KEY} })

		# Scan through the results
		result.parsed_response["results"].map do |film|

		# For each one we're going to make a new movie object with the values filled in 
		Movie.new(
			title: film["title"], 
			synopsis: film["overview"], 
			rating: film["vote_average"], 
			year: film["release_date"][0, 4], 
			image_url: film["poster_path"]
			)
		end
	end
end