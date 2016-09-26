require 'json'

class BookingbugAdapter
  include HTTParty

  base_uri 'https://us.bookingbug.com/api/v1'

  def initialize
    @basic_auth = { email: ENV['BOOKING_BUG_EMAIL'],
                    password: ENV['BOOKING_BUG_PASSWORD'] }
    @booking_bug_key = ENV['BOOKING_BUG_KEY']
    @booking_bug_id =  ENV['BOOKING_BUG_ID']
    @company_id = ENV['BOOKING_BUG_COMPANY_ID']
    @headers = { headers: { 
                            'App-Key' => @booking_bug_key,
                            'App-Id' => @booking_bug_id
                          }
    get_auth_token
    # @clients = get_existing_clients
    # @slots = get_available_slots
  end

  def auth_token
    @auth_token
  end

  def test_endpoint(endpoint, options = {})
    self.class.get(endpoint, options)
  end

  def get_auth_token
    login_body = { body:  {
                              "email" => @basic_auth[:email],
                              "password" => @basic_auth[:password]
                           }
    }
    login_options = @headers.merge(login_body)
    response = self.class.post('/login', login_options)
    @headers[:headers]['Auth-Token'] = response['auth_token']

    ap "*" * 100
    ap @headers[:headers]['Auth-Token']
  end

  def get_company
    ap test_endpoint("/admin/#{@company_id}/company", @headers)
  end

  def get_locations
    test_endpoint("/admin/#{@company_id}/addresses", @headers)
  end

  def get_services
    test_endpoint("/admin/#{@company_id}/services", @headers)
  end

  def get_available_slots
    test_endpoint("/#{@company_id}/services/time_data", @headers)
  end

  def collect_user_details
    test_endpoint("/#{@company_id}/questions?detail_group_id=", #ADD DETAIL GROUP ID
    @headers)
  end

  def get_existing_clients
    test_endpoint("/admin/#{@company_id}", @headers)
    # "/client{/id}{?page,per_page,filter_by,filter_by_fields,order_by,order_by_reverse,search_by_fields}",
  end

  def get_client_by_email(email)
    test_endpoint("/#{@company_id}/client/find_by/#{email}", @headers)
  end

  def post_client(client = {})
    self.class.post("/#{@company_id}/client", @headers)
  end

  def confirm_booking
    self.class.post("/#{@company_id}/#SOMETHING", @headers)
  end

  def add_to_basket
    self.class.post("/#{@company_id}/basket/add_item(?)", #SOMETHING 
    @headers)
  end

  def get_basket
    test_endpoint("/#{@company_id}/basket", @headers)
  end

  def checkout(email)
    @member_id = post_client(email: email)
    self.class.post("#{@company_id}/basket/checkout{?#{@member_id},take_from_wallet")
  end
end

