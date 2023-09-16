require 'sinatra'
require_relative 'game'

set :public_folder, File.join(File.dirname(__FILE__), 'public')
set :server, 'webrick'

snake_game = SnakeGame.new(20, 20, 20)

get '/' do
  erb :index, locals: { snake_game: snake_game }
end

get '/api/move/:direction' do
  direction = params[:direction]
  snake_game.move(direction)
  { snake: snake_game.snake, food: snake_game.food, game_over: snake_game.game_over }.to_json
end

get '/api/move/init' do
  { snake: snake_game.snake, food: snake_game.food, game_over: snake_game.game_over }.to_json
end
