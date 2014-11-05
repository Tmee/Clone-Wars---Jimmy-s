require 'bundler'
Bundler.require
require_relative './app/menu_database'


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

  get '/reserve' do
    erb :reservation
  end

  get '/menu' do
    erb :menu, layout: :menu_layout
  end

  get '/location' do
    erb :location
  end

  get '/contact_us' do
    erb :contact_us
  end

  # ========== Admin Areas ========== #

  get '/admin' do
    protected!
    erb :admin, layout: :admin_layout
  end

  get '/admin/home' do
    respond
  end

  get '/admin/about_us' do
    erb :admin_about_us, layout: :admin_layout
  end

  get '/admin/menu' do
    menu_items = MenuDatabase.all_menu_items
    erb :admin_menu, locals: { menu_items: menu_items }, layout: :admin_layout
  end

  get '/admin/location' do
    respond
  end

  get '/admin/contact_us' do
    respond
  end

  get '/admin/reserve' do
    respond
  end

  # ====== Admin Edit / Save / Delete ====== #

  #menu editing

  post '/' do
    MenuDatabase.create(params[:id])
    redirect '/admin/menu'
  end

  delete '/:id' do |id|
    MenuDatabase.delete(id.to_i)
    redirect '/admin/menu'
  end

  post '/1/about_us' do
    respond
  end

  post '/2/about_us' do
    respond
  end


# ======== End Admin ======== #

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
        :body => name + " says " + message,
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

  def respond
    "Thanks for the input, I'll make sure not to use it."
  end

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
