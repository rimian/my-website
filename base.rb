require 'sinatra'

configure do
  set :root, 'app'
end

get '/app.css' do
  content_type :css
  scss :app, :views => "#{settings.root}/assets/stylesheets/"
end

get '/' do
  @title = 'Rimian Perkins - Freelance Software Engineer'
  @google_analytics_code = 'UA-100831510-1'
  erb :app
end
