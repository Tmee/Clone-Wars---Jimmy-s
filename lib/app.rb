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
    mail_info = { name: params[:name],
                  subject: params[:subject] || "(no subject)",
                  email: params[:mail],
                  message: params[:message],
                }

    Mailer.send_mail(mail_info)
  end
end
