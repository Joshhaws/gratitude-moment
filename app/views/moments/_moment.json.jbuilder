json.extract! moment, :id, :user_id, :phone, :body, :twilio_id, :created_at, :updated_at
json.url moment_url(moment, format: :json)