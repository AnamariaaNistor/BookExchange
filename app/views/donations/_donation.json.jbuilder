json.extract! donation, :id, :sending_status, :recieving_status, :process_status, :created_at, :updated_at
json.url donation_url(donation, format: :json)
