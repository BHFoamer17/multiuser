json.array!(@providers) do |provider|
  json.extract! provider, :id, :company_name, :phone
  json.url provider_url(provider, format: :json)
end
