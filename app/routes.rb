require 'sinatra'
require 'json'

before do
  content_type :json
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
end

get '/hello' do
  {:title => 'heyyyooo'}.to_json
end

not_found do
  halt 404, 'Route not created for this!!!'
end
