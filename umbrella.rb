line_width = 40


puts "=========================================="
puts  "   Will you need an umbrella today?"
puts "=========================================="


pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER")
gmaps_key = ENV.fetch("GMAPS_KEY")


require "http"
require "json"

puts ""
puts "Where are you located?"

user_location = gets.chomp


maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

resp = HTTP.get(maps_url)
raw_response = resp.to_s

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

lat = loc.fetch("lat")
lng = loc.fetch("lng")

puts "Checking weather at " + user_location.to_s + "..."
puts "Your coordianates are " + lat.to_s + ", " + lng.to_s + "."


weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + lat.to_s + "," + lng.to_s

resp2 = HTTP.get(weather_url)
raw_response2 = resp2.to_s
parsed_response2 = JSON.parse(raw_response2)

currently = parsed_response2.fetch("currently")
current_temperature = currently.fetch("temperature")
puts "It is currently " + current_temperature.to_s + "°F."

current_summary = currently.fetch("summary").to_s
current_summary = current_summary.capitalize
puts "Next hour: " + current_summary

precip_probability = currently.fetch("precipProbability")

if precip_probability <= 33
  puts "You probably won't need an umbrella."
  elsif precip_probability > 33 && precip_probability <= 67
  puts "You might need an umbrella."
  elsif precip_probability > 67
    puts "You definitely need an umbrella."
  
end
