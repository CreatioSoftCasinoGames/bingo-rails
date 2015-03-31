json.array!(@ais) do |ai|
  json.extract! ai, :id, :name, :active
  json.url ai_url(ai, format: :json)
end
