require 'bundler'
Bundler.require
require_relative './app/menu_database'


class JimmysApp < Sinatra::Base
  register Sinatra::Reloader
  set :method_override, true
  set :root, 'lib/app'

  configure do
    DB = MenuDatabase.new
  end

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
    menu_categories = DB.all_menu_categories
    menu_items      = DB.all_menu_items
    erb :menu, locals: {menu_items: menu_items, menu_categories: menu_categories}, layout: :menu_layout
  end

  get '/location' do
    erb :location
  end

  get '/contact_us' do
    erb :contact_us
  end

  get '/item_description/:id' do |id|
    menu_item     = DB.find_menu_item(id)
    item_category = DB.find_item_category(id)
    erb :item_description, locals: {menu_item: menu_item, item_category: item_category}
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
    menu_categories = DB.all_menu_categories
    menu_items      = DB.all_menu_items
    erb :admin_menu, locals: { menu_items: menu_items, menu_categories: menu_categories }, layout: :admin_layout
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

  put '/admin/:id' do
    DB.update_menu_item(params)
    redirect '/admin/menu'
  end

  delete '/admin/:id' do |id|
    DB.delete(id)
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

  post '/jimmys-urban-bar-and-grill-reservations-denver' do
    resname = params[:resname]
    day = params[:day]
    month = params[:month]
    year = params[:year]
    party = params[:partysize]
    time = params[:time]

    require 'pony'
    Pony.mail({
        :to => 'larsonkonr@gmail.com',
        :from => resname,
        :subject => "Reservation for: #{resname}",
        :body => "#{resname} would like a reservation for #{party} guests on #{month} / #{day} / #{year} at #{time} ",
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
