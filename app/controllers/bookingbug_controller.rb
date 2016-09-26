get '/bookingbug' do 
  @booking_bug = BookingbugAdapter.new
  ap "*" * 75 + "REQUEST" + "*" * 75
  ap @booking_bug.get_training_slots
  ap "*" * 150
  erb :'booking_bug/index'
end