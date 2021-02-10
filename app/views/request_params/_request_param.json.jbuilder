json.extract! request_param, :id, :request_id, :name, :value, :created_at, :updated_at
json.url request_param_url(request_param, format: :json)
