class BookingbugAdapter
  include HTTParty

  base_uri 'http://apidocs.bookingbug.com/swagger-public.json'

  def initialize(args = {})
    
  end

  def test_endpoint(endpoint)
    self.class.get(endpoint)
  end
end

