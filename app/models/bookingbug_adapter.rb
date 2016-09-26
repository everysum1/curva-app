require 'json'

class BookingbugAdapter
  include HTTParty

  base_uri 'https://us.bookingbug.com/api/v1'

  def initialize
    @basic_auth = {    email: ENV['BOOKING_BUG_EMAIL'],
                    password: ENV['BOOKING_BUG_PASSWORD'] }
    @booking_bug_key = ENV['BOOKING_BUG_KEY']
    @booking_bug_id =  ENV['BOOKING_BUG_ID']
    @company_id = ENV['BOOKING_BUG_COMPANY_ID']
    @headers = { headers: { 
                            'App-Key' => @booking_bug_key,
                             'App-Id' => @booking_bug_id
                          }
    }
    get_auth_token
    @locations = get_locations['addresses']
    @services = get_services['services']
    # @clients = get_existing_clients
    # @slots_open = get_available_slots
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
  end

  def get_company
    test_endpoint("/admin/#{@company_id}/company", @headers)
  end

  def get_locations
    test_endpoint("/admin/#{@company_id}/addresses", @headers)
  end

  def get_services
    test_endpoint("/admin/#{@company_id}/services", @headers)
  end

  def get_service_id(service)
    # SOMETHING
  end

  def get_training_slots_by_days(startdate, enddate, get_service_id(service))
    test_endpoint("/#{@company_id}/services?service_id=74695&date=YYYY-MM-DD&end_date=YYYY-MM-DD&duration=60", @headers)
  end

  def get_trainer_slots(trainer)
    test_endpoint("/#{@company_id}/services?service_id=74695&date=YYYY-MM-DD&end_date=YYYY-MM-DD&duration=60", @headers)
  end

  def 

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

