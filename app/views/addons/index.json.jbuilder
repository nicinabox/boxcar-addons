json.array!(@addons) do |addon|
  json.extract! addon, :name, :endpoint
  json.url addon_url(addon, format: :json)
end
