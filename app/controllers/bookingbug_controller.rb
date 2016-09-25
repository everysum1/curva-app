get '/bookingbug' do 
  @booking_bug = BookingbugAdapter.new
  ap @booking_bug.test_endpoint('/')
  erb :'booking_bug/index'
end