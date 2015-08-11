json.array!(@tenants) do |tenant|
  json.extract! tenant, :id, :name, :phone
  json.url tenant_url(tenant, format: :json)
end
