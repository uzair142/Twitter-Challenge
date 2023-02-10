require_relative 'lib/database_connection'
require 'sinatra/base'
require 'sinatra/reloader'
#require_relative 'lib/chitter'
#require_relative 'lib/chitter_repository'

# require 'lib/username_repository'

DatabaseConnection.connect('chitters_test')

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb(:index)
  end

  post '/createaccount' do
    username = params[:username]
    password = params[:password]
    lol = LoginRepository.new
    lol.create(username, password)
    return erb(:index)
  end
end