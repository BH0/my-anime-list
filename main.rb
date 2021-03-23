# note: maybe in the future I'll attempt the app using Julia or Crystal 
# note: Ruby seems to handle JSON differently to what I expected so technically I am not using JSON 
require 'sinatra'
require 'json'
require 'sinatra/cross_origin'

configure do
    enable :cross_origin
  end
before do
	response.headers['Access-Control-Allow-Origin'] = '*'
end
before do
  content_type :json
end

options "*" do
	response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
	response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
	response.headers["Access-Control-Allow-Origin"] = "*"
	200
end

get '/anime' do
	file_data = File.read("anime.json").split
	puts file_data.to_json
	for anime in file_data  
		puts anime.to_json
	end 
	# { title: "akame ga kill" }.to_json
end


post '/anime' do
	push = JSON.parse(request.body.read)
	File.write('anime.json', push.inspect + ",", mode: 'a') 
end

# curl -i -X POST -H "Content-Type: application/json" -d "{\"title\":\"parasite\"}" http://localhost:4567/anime
# curl -i -X POST -H "Content-Type: application/json" -d "{\"title\":\"parasite\", \"rating\":\"meh\", \"soundtrack\":\"good\", \"platform\":\"netflix\" }" http://localhost:4567/anime
