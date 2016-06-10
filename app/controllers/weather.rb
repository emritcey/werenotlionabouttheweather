post '/weather' do
  city = params[:city].gsub(/,*\s+/, "")
  p city
  redirect "/weather/#{city}"
end

get '/weather/:city' do
  @city = params[:city]
  options = {units: "imperial", APPID: "ade7879e25da1c374b2251a167451a1a" }
  @weather = OpenWeather::Current.city(@city, options)
  erb :show
end


post '/weather/:city/text' do
  city = params[:city]
  to = params[:to]
  lion = choose_photo(@weather)
  options = {units: "imperial", APPID: "ade7879e25da1c374b2251a167451a1a"}
  @weather = OpenWeather::Current.city(@city, options)

  account_sid = 'AC5486bfc14c098eaec4f0b81119d197f5'
  auth_token = '7f91d84504667848c42f76def0ef79c3'
  @client = Twilio::REST::Client.new account_sid, auth_token

  @client.account.messages.create({
    from: "",
    to: "#{to}",
    body: "It is #{weather[0]["main"]} in #{city} with a temperature of #{weather[0]["temp"]}.",
    media_url: "#{lion}"
  })

end
