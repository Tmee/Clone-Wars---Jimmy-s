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
    protected!
    erb :admin
  end

  post '/contact_us' do
    name = params[:name]
    subject = params[:subject] || ""
    email = params[:mail]
    message = params[:message]
  end


  post '/contact_us_reserve' do
    nothing
  end

  get '/admin/menu' do

  end

  post '/admin' do
    protected!
    "Thanks for all the changes!  I most likely will do nothing with them!"
  end




    # require 'pony'
    # Pony.mail({
    #     :to => 'larsonkonr@gmail.com',
    #     :from => email,
    #     :subject => subject,
    #     :body => message,
    #     :via => :smtp,
    #     :via_options => {
    #      :address              => 'smtp.gmail.com',
    #      :port                 => '587',
    #      :enable_starttls_auto => true,
    #      :user_name            => 'thisisafake@gmail.com',
    #      :password             => 'fakepassword',
    #      :authentication       => :plain,
    #      :domain               => "http://lodojimmys.herokuapp.com/"
    #      }
    #   })
    #   redirect '/'
    # end




  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? &&
    @auth.credentials && @auth.credentials == ['admin', 'admin']
  end
end

