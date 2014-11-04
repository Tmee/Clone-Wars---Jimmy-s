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

  get '/admin' do
    erb :admin
  end

  post '/admin' do
    puts "Thank you for logging in"
    redirect '/'
  end

  post '/contact_us' do
    name = params[:name]
    subject = params[:subject] || ""
    email = params[:mail]
    message = params[:message]

    require 'pony'
    Pony.mail({
        :to => 'larsonkonr@gmail.com',
        :from => email,
        :subject => subject,
        :body => message,
        :via => :smtp,
        :via_options => {
         :address              => 'smtp.gmail.com',
         :port                 => '587',
         :enable_starttls_auto => true,
         :user_name            => 'larsonkonr@gmail.com',
         :password             => '9am380y1',
         :authentication       => :plain,
         :domain               => "http://lodojimmys.herokuapp.com/"
         }
      })
      redirect '/'
   end
end
