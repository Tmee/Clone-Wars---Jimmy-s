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

  # post '/contact_us' do
  #   name = params[:name]
  #   subject = params[:subject] || ""
  #   email = params[:mail]
  #   message = params[:message]
  #
  #   Pony.mail(:to => 'larsonkonr@gmail.com',
  #             :from => email,
  #             :subject => subject,
  #             :body => message)
  # end



  post '/contact' do
  require 'pony'
  Pony.mail({
  :from => params[:name],
      :to => 'larsonkonr@gmail.com',
      :subject => params[:name] + "has contacted you via the Website",
      :body => params[:message],
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
   end
end
