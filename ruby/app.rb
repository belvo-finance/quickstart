require 'base64'
require 'date'
require 'json'
require 'belvo'
require 'sinatra'
require 'httparty'

# Fill in your Belvo API keys - https://dashboard.belvo.co
BELVO_SECRET_ID = ENV['BELVO_SECRET_ID']
BELVO_SECRET_PASSWORD = ENV['BELVO_SECRET_PASSWORD']
# Use `sandbox` to test with Belvo's Sandbox environment
# Use `production` to go live
BELVO_ENV = ENV['BELVO_ENV']
puts BELVO_ENV

BELVO_ENV_URL = 'https://sandbox.belvo.co' 

if not BELVO_ENV and BELVO_ENV == 'sandbox'
  BELVO_ENV_URL = 'https://api.belvo.co'
end

puts BELVO_ENV_URL
puts BELVO_SECRET_ID
puts BELVO_SECRET_PASSWORD

belvo = Belvo::Client.new(
  BELVO_SECRET_ID,
  BELVO_SECRET_PASSWORD,
  BELVO_ENV_URL
)

auth = {:username => BELVO_SECRET_ID, :password => BELVO_SECRET_PASSWORD}

before do
  request.body.rewind
  @request_payload = JSON.parse(request.body.read, symbolize_names: true)
end

# Request an access token to be used when loading the Widget
# https://developers.belvo.co/docs/connect-widget#section--3-generate-an-access_token-
get '/get_token' do
  url = BELVO_ENV_URL + '/api/token/'
  response = HTTParty.post(url, body: {id: BELVO_SECRET_ID, password: BELVO_SECRET_PASSWORD,
    scopes: "read_institutions,write_links,read_links,delete_links"}, :basic_auth => auth)
  pretty_print_response(response)
  content_type :json
  response.to_json
end

post '/accounts' do
  response = belvo.accounts.retrieve(link: @request_payload[:link_id])
  pretty_print_response(response)
  content_type :json
  response.to_json
end

post '/transactions' do
  response = belvo.transactions.retrieve(
    link: params['link_id'],
    date_from: params['date_from'],
    date_to: params['date_to']
  )
  pretty_print_response(response)
  content_type :json
  response.to_json
end

post '/balances' do
  response = belvo.balances.retrieve(
    link: params['link_id'],
    date_from: params['date_from'],
    date_to: params['date_to']
  )
  pretty_print_response(response)
  content_type :json
  response.to_json
end

post '/owners' do
  response = belvo.owners.retrieve(
    link: params['link_id']
  )
  pretty_print_response(response)
  content_type :json
  response.to_json
end

post '/statements' do
  response = belvo.statements.retrieve(
    link: params['link_id'],
    account: params['account-id'],
    year: params['year'],
    month: params['month']
  )
  pretty_print_response(response)
  content_type :json
  response.to_json
end


def format_error(err)
  { error: {
      error_code: err.error_code,
      error_message: err.error_message,
      error_type: err.error_type
    }
  }
end

def pretty_print_response(response)
  puts JSON.pretty_generate(response)
end
