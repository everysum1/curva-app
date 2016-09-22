get '/' do
  erb :'static_pages/index'
end

get '/about' do
  erb :'static_pages/about'
end

get '/schedule' do
  erb :'static_pages/schedule'
end

get '/classes' do
  erb :'static_pages/classes'
end

get '/ketogenics' do
  erb :'static_pages/ketogenics'
end

get '/blog' do
  erb :'static_pages/blog'
end

get '/training' do
  erb :'static_pages/training'
end 

get '/contact' do
  erb :'static_pages/contact'
end

get '/store' do
  erb :'static_pages/store'
end
