json.extract! entry, :id, :blog_id, :title, :body, :created_at, :updated_at
json.url entry_url(entry, format: :json)