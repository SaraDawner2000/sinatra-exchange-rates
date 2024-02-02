require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @valid_currencies = parsed_data["currencies"] 
  erb(:homepage)
end
