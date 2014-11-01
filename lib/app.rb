require 'bundler'
Bundler.require

class JimmysApp < Sinatra::Base
  register Sinatra::Reloader
  set :method_override, true
  set :root, 'lib/app'


  get '/' do
    erb :index
  end

  get '/about-us' do
    erb :about_us
  end

  get '/menu' do
    erb :menu
  end

  get '/location' do
    erb :location
  end

  post '/contact-us' do
    erb :contact_us
  end
end
