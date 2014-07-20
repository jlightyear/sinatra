require 'sinatra'
require 'pry'
require 'pstore'
require 'json'
require 'sinatra/reloader' if development?

store = PStore.new("data.pstore")

get '/' do
	store.transaction do
		@task_array = store[:item_list]
		@task_array ||=[]
	end
	@i=0
	erb :index
end

get '/beta' do

	erb :beta
end

get '/get' do
	store.transaction do
		@task_array = store[:item_list]
		@task_array ||=[]
		@task_array.to_json
	end
end

post '/send' do
	store.transaction do
		store[:item_list] ||=[]
		store[:item_list] << params["key"]
	end	
end

post '/add_task' do
	store.transaction do
		store[:item_list] ||=[]
		store[:item_list] << params["task"]
	end
	redirect to("/")
end

post '/remove_task' do
	puts '=========================================================='
	puts params
	store.transaction do
			array_params = []
			params.each {|k,v| array_params << k.to_i}
			array_params.reverse!
			array_params.each {|k| store[:item_list].delete_at(k.to_i) }
	end
	redirect to("/")
end
