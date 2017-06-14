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
  configure_pony
  # name = params[:name]
  # sender_email = params[:email]
  # message = params[:message]
  logger.error params.inspect
  begin
    Pony.mail(
      :from => ENV['SENDGRID_RECIPIENT_ADDRESS'], # "#{name}<#{sender_email}>",
      :to => ENV['SENDGRID_RECIPIENT_ADDRESS'], #'example@gmail.com',
      :subject => 'test sendgrid', # "#{name} has contacted you",
      :body => 'hello world', #"#{message}",
    )
    redirect '/success'
  rescue
    @exception = $!
    erb :boom
  end
end

def configure_pony
  Pony.options = {
    :via => :smtp,
    :via_options => {
      :address              => 'smtp.sendgrid.net',
      :port                 => '587',
      :user_name            => ENV['SENDGRID_USERNAME'],
      :password             => ENV['SENDGRID_PASSWORD'],
      :authentication       => :plain,
      :enable_starttls_auto => true,
      :domain               => 'heroku.com'
    }
  }
end
