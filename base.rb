require 'sinatra'
require 'json'

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
  halt 200, params.to_json
end
