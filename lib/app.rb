require 'bundler'
Bundler.require


class JimmysApp < Sinatra::Base
  register Sinatra::Reloader
  set :method_override, true
  set :root, 'lib/app'
  attr_reader :username, :password


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
# require 'mail'
# Mail.defaults do
#   delivery_method :smtp, { :address   => "smtp.sendgrid.net",
#                            :port      => 587,
#                            :domain    => "http://lodojimmys.herokuapp.com/",
#                            :user_name => "larsonkonr",
#                            :password  => "gameboy1",
#                            :authentication => 'plain',
#                            :enable_starttls_auto => true }
# end
# post '/message' do
#   mail = Mail.deliver do
#     to 'yourRecipient@domain.com'
#     from "Your Name #{params[:name]}"
#     subject 'This is the subject of your email'
#     text_part do
#       body 'Hello world in text'
#     end
#     html_part do
#       content_type 'text/html; charset=UTF-8'
#       body '<b>Hello world in HTML</b>'
#     end
#   end
# end

  # mail = SendGrid::Mail.new do |m|
  #   m.to = 'larsonkonr@gmail.com'
  #   m.from = :from
  #   m.subject = :subject
  #   m.text = :body
  # end
  #
  # post '/message' do
  #   Pony.mail(:to => 'larsonkonr@gmail.com', :from => params[:name], :subject => 'Feedback from ' + params[:name], :body => params[:message])
  #   redirect '/'
  # end
  # post '/contact' do
  # require 'pony'
  # Pony.mail({
  # :from => params[:name],
  #     :to => 'larsonkonr@gmail.com',
  #     :subject => params[:name] + "has contacted you via the Website",
  #     :body => params[:message],
  #     :via => :smtp,
  #     :via_options => {
  #      :address              => 'smtp.gmail.com',
  #      :port                 => '587',
  #      :enable_starttls_auto => true,
  #      :user_name            => 'larsonkonr@gmail.com',
  #      :password             => '9am380y1',
  #      :authentication       => :plain,
  #      :domain               => "http://lodojimmys.herokuapp.com/"
  #      }
  #   })
  #  end
end
