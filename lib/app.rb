require 'bundler'
Bundler.require


class JimmysApp < Sinatra::Base
  register Sinatra::Reloader
  set :method_override, true
  set :root, 'lib/app'


  get '/' do
    erb :index
  end

  get '/about_us' do
    erb :about_us
  end

  get '/menu' do
    erb :menu
  end

  get '/location' do
    erb :location
  end

  get '/contact_us' do
    erb :contact_us
  end

  post '/contact_us' do
    name = params[:name]
    subject = params[:subject] || ""
    email = params[:mail]
    message = params[:message]

    Pony.mail(:to => 'gregnar@gmail.com',
              :from => email,
              :subject => subject,
              :body => message)
  end
end
