get '/checkfront' do
  @checkfront = CheckfrontAdapter.new
  ap @checkfront.test_endpoint("/booking")["booking/index"]
  erb :'checkfront/index'
end