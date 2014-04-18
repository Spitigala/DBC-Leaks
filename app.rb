require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do 
	@dbc = "Hello world!"
	erb :home
end

get '/about' do
	erb :about
end

not_found do
  erb :not_found
end