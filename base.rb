require 'sinatra'

configure do
  set :root, 'app'
end

get '/app.css' do
  content_type :css
  scss :app, :views => "#{settings.root}/assets/stylesheets/"
end

get '/' do
  @google_analytics_code = 'UA-100831510-1'
  erb :app
end

get '/success' do
  'Yay!'
end

post '/' do
  # configure_pony
  # name = params[:name]
  # sender_email = params[:email]
  # message = params[:message]
  logger.error params.inspect

  begin

    Mail.defaults do
      delivery_method :smtp, {
        :address => 'smtp.sendgrid.net',
        :port => 587,
        :domain => 'heroku.com',
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => 'plain',
        :enable_starttls_auto => true
      }
    end

    mail = Mail.deliver do
        to ENV['SENDGRID_RECIPIENT_ADDRESS']
        from ENV['SENDGRID_RECIPIENT_ADDRESS']
        subject 'Feedback for my Sintra app'
        text_part do
          'hello world'
        end
    end

    redirect '/success'
  rescue
    @exception = $!
    
  end
end
