json.extract! request_example, :id, :request_id, :name, :content_type, :body, :created_at, :updated_at
json.url request_example_url(request_example, format: :json)
