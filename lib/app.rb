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
  end

  get '/menu' do
  end

  get '/location' do
  end

  post '/contact-us' do
  end
end
