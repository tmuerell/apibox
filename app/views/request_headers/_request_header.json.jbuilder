json.extract! request_header, :id, :request_id, :name, :value, :created_at, :updated_at
json.url request_header_url(request_header, format: :json)
