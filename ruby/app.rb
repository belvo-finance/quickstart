require 'base64'
require 'date'
require 'json'
require 'belvo'
require 'sinatra'
require 'sinatra/cross_origin'
require 'httparty'

# Fill in your Belvo API keys - https://dashboard.belvo.co
BELVO_SECRET_ID = ENV['BELVO_SECRET_ID']
BELVO_SECRET_PASSWORD = ENV['BELVO_SECRET_PASSWORD']
# Use `sandbox` to test with Belvo's Sandbox environment
# Use `production` to go live
BELVO_ENV = ENV['BELVO_ENV']
BELVO_ENV_URL = 'https://sandbox.belvo.co' 

if not BELVO_ENV and BELVO_ENV == 'sandbox'
  BELVO_ENV_URL = 'https://api.belvo.co'
end

set :port, 5000
set :bind, '0.0.0.0'
  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

  200
end
  
belvo = Belvo::Client.new(
  BELVO_SECRET_ID,
  BELVO_SECRET_PASSWORD,
  BELVO_ENV_URL
)

auth = {:username => BELVO_SECRET_ID, :password => BELVO_SECRET_PASSWORD}

before do
  if request.body
    request.body.rewind
    @request_payload = JSON.parse(request.body.read.to_json)
  end
end


# Request an access token to be used when loading the Widget
# https://developers.belvo.co/docs/connect-widget#section--3-generate-an-access_token-
get '/get_token' do
  url = BELVO_ENV_URL + '/api/token/'
  response = HTTParty.post(url, body: {id: BELVO_SECRET_ID, password: BELVO_SECRET_PASSWORD,
    scopes: "read_institutions,write_links,read_links,delete_links"}, :basic_auth => auth)
  pretty_print_response(response)
  content_type :json
  JSON.parse(response.to_json)
end

post '/accounts' do
  link_id = JSON.parse(@request_payload)['link_id']

  response = belvo.accounts.retrieve link: link_id
  pretty_print_response(response)
  content_type :json
  response.to_json
end

post '/transactions' do
  link_id = JSON.parse(@request_payload)['link_id']

  response = belvo.transactions.retrieve(
    link: link_id,
    date_from: (Date.today - 30),
    options: { "date_to": Date.today}
  )
  pretty_print_response(response)
  content_type :json
  response.to_json
end

post '/balances' do
  link_id = JSON.parse(@request_payload)['link_id']

  response = belvo.balances.retrieve(
    link: link_id,
    date_from: (Date.today - 30),
    options: { "date_to": Date.today}
  )
  pretty_print_response(response)
  content_type :json
  response.to_json
end

post '/owners' do
  link_id = JSON.parse(@request_payload)['link_id']

  response = belvo.owners.retrieve(
    link: link_id
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
