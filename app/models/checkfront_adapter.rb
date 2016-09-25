class CheckfrontAdapter
  include HTTParty

  base_uri 'https://israelitech.checkfront.com/api/3.0'

  def initialize(args = {})
    # @username = args[:username]
    # @password = args[:password]
    @auth = { username: ENV['CHECKFRONT_KEY'], password: ENV['CHECKFRONT_SECRET'] }
    # test_stuff
  end

  # def test_stuff
  #   @github.test_endpoint("/")
  # end

  def test_endpoint(endpoint)
    self.class.get(endpoint, basic_auth: @auth)
  end

  def get_bookings
    test_endpoint('/booking', basic_auth: @auth)["booking/index"]
  end
end