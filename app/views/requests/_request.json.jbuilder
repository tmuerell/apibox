json.extract! request, :id, :name, :url, :method, :content_type, :body, :folder_id, :created_at, :updated_at
json.url request_url(request, format: :json)
