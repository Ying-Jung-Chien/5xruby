json.extract! user, :id, :name, :password, :position, :created_at, :updated_at
json.url user_url(user, format: :json)
