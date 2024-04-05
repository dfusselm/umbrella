pp "howdy"

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER")
gmaps_key = ENV.fetch("GMAPS_KEY")


require "http"
require "json"


pp "Where are you located?"

user_location = gets.chomp


maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location+ "&key=" + ENV.fetch("GMAPS_KEY")

pp maps_url


resp = HTTP.get(maps_url)
raw_response = resp.to_s

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

lat = loc.fetch("lat")
lng = loc.fetch("lng")

pp lat
pp lng
