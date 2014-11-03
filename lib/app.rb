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

    Pony.mail({
              :to => 'larsonkonr@gmail.com',
              :from => email,
              :subject => subject,
              :body => message,
              :via => :smtp,
              :via_options => {
                :address        => 'smtp.yourserver.com',
                :port           => '25',
                :user_name      => 'user',
                :password       => 'password',
                :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
                :domain         => "localhost.localdomain" # the HELO domain provided by the client to the server
              }
      })
  end
end
