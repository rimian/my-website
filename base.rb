require 'sinatra'
require 'json'
require 'mailgun'

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

post '/' do
  mg_client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])

  message_params = {
    from: ENV['WEBFORM_RECIPIENT'],
    to: ENV['WEBFORM_RECIPIENT'],
    subject: "Webform: #{params['name']}",
    text: "Name: #{params['name']}\nEmail: #{params['email']}\nPhone: #{params['phone']}\nInfo: #{params['info']}\n"
  }

  result = mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params

  halt 200, params.to_json
end
