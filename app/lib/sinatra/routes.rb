require 'sinatra'
require 'json'
require_relative 'board/board'

before do
  content_type :json
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
end

get '/' do
  {:greeting => 'hi'}.to_json
end

get '/get_board_size' do
  {:board_size => 5}.to_json
end

not_found do
  halt 404, 'Route not created for this!!!'
end
