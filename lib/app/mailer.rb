module Mailer

  def self.send_mail(options = {})
    Pony.mail(:to => 'gregnar@gmail.com',
              :from => options[:email],
              :subject => options[:subject],
              :body => options[:message])
  end

end
