post '/weather' do
  city = params[:city].gsub(/,*\s+/, "")
  p city
  redirect "/weather/#{city}"
end

get '/weather/:city' do
  @city = params[:city].lstrip
  options = {units: "imperial", APPID: "ade7879e25da1c374b2251a167451a1a" }
  @weather = OpenWeather::Current.city(@city, options)
  erb :show
end
