# IF CHALLENGE CALLS FOR IT: PREVENT ACCESS TO HIDDEN PAGES 

#registration page
get '/users/new' do
  erb :'/users/new'
end

#registration working
post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}" 
  else
    @errors = @user.errors.full_messages 
    erb :'/users/new'
  end
end

#login page
get '/login' do
  erb :'/users/login'
end

post '/login' do 
@user = User.find_by(username: params[:user][:username])
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = "That doesn't look right... try again."
    erb :'/users/login'
  end
end

#autheticate login
get '/users/:id' do
  @user = User.find(params[:id])
  erb :'/users/show'
end

#logout
get '/logout' do
  session.delete(:user_id)
  redirect '/'
end