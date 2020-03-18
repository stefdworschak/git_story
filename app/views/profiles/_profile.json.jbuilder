json.extract! profile, :id, :fullname, :github_username, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
