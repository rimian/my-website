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
  mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']

  message_params = {
    from: params[:email],
    to: ENV['WEBFORM_RECIPIENT'],
    subject: "Webform: #{params[:name]}",
    text: params[:info]
  }

  result = mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params

  halt 200, params.to_json
end
