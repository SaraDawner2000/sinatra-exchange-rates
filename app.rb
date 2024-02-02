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

get("/:from_currency") do
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @valid_currencies = parsed_data["currencies"]
  @from_currency = params[:from_currency]
  erb(:convert_list)
end

get("/:from_currency/:to_currency") do
  @from_currency = params[:from_currency]
  @to_currency = params[:to_currency]
  api_url = "http://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@from_currency}&to=#{@to_currency}&amount=1"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @exchange_rate = parsed_data["result"]
  erb(:converted_page)
end
