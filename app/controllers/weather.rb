require 'rubygems'
require 'twilio-ruby'

post '/weather' do
  city = params[:city].gsub(/,*\s+/, "")
  p city
  redirect "/weather/#{city}"
end

get '/weather/:city' do
  @city = params[:city]
  options = {units: "imperial", APPID: "*************************" }
  @weather = OpenWeather::Current.city(@city, options)
  erb :show
end


post '/weather/:city/text' do
  @city = params[:city]
  to = params[:to].gsub("-", "").gsub("\s", "")
  options = {units: "imperial", APPID: "*************************"}
  @weather = OpenWeather::Current.city(@city, options)

  conditions = @weather["main"]["temp"]
  high = @weather["main"]["temp_max"]
  low = @weather["main"]["temp_min"]

  lion = choose_photo(@weather)

  account_sid = "*********************************"
  auth_token = "*********************************"
  @client = Twilio::REST::Client.new account_sid, auth_token

  @client.account.messages.create({
    body: "------------------------- It is #{conditions} degrees in #{@city}. With a high of #{high} degrees and a low of #{low}. We aren't lion.",
    to: "+#{to}",
    from: "+12513336060",
    media_url: "#{lion}"
  }).status

  redirect '/'
end
