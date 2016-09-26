class BookingbugAdapter
  include HTTParty

  base_uri 'https://us.bookingbug.com/api/v1'

  def initialize(args = {})
    @basic_auth = { email: ENV['BOOKING_BUG_EMAIL'],
                    password: ENV['BOOKING_BUG_PASSWORD'] }
    @company_id = ENV['BOOKING_BUG_COMPANY_ID']
    @auth_token = post_login_for_auth_token
    @clients = get_existing_clients[:clients]
    @slots = get_available_slots
  end

  def test_endpoint(endpoint)
    self.class.get(endpoint)
  end

  def post_login_for_auth_token
    self.class.post('/login', basic_auth: @basic_auth)
    #add body with admin email/password
  end

  def get_company
    test_endpoint("/admin/#{@company_id}/company")
  end

  def get_locations
    test_endpoint("/admin/#{@company_id}/addresses", basic_auth: @basic_auth, auth_token: @auth_token)
  end

  def get_services
    test_endpoint("/admin/#{@company_id}/services", basic_auth: @basic_auth, auth_token: @auth_token)
  end

  def get_available_slots
    test_endpoint("/#{@company_id}/services/time_data", basic_auth: @basic_auth, auth_token: @auth_token)
  end

  def collect_user_details
    test_endpoint("/#{@company_id}/questions?detail_group_id=", #ADD DETAIL GROUP ID
    basic_auth: @basic_auth, auth_token: @auth_token)
  end

  def get_existing_clients
    test_endpoint("/admin/#{@company_id}", basic_auth: @basic_auth, auth_token: @auth_token)
    # "/client{/id}{?page,per_page,filter_by,filter_by_fields,order_by,order_by_reverse,search_by_fields}",
  end

  def get_client_by_email(email)
    test_endpoint("/#{@company_id}/client/find_by/#{email}", basic_auth: @basic_auth, auth_token: @auth_token)
  end

  def post_client(client = {})
    self.class.post("/#{@company_id}/client", basic_auth: @basic_auth)
  end

  def confirm_booking
    self.class.post("/#{@company_id}/#SOMETHING", basic_auth: @basic_auth)
  end

  def add_to_basket
    self.class.post("/#{@company_id}/basket/add_item(?)", #SOMETHING 
    basic_auth: @basic_auth)
  end

  def get_basket
    test_endpoint("/#{@company_id}/basket", basic_auth: @basic_auth, auth_token: @auth_token)
  end

  def checkout(email)
    @member_id = post_client(email: email)
    self.class.post("#{@company_id}/basket/checkout{?#{@member_id},take_from_wallet"}
  end
end

