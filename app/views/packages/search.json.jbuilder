# gross
unique_package_names = @packages.collect { |p| p.name }.uniq
json.array!(unique_package_names) do |package_name|
  json.name package_name
  json.summary @packages.select {|p| p.name == package_name }.first.summary
  json.versions @packages.collect { |p|
                  p.version if p.name == package_name
                }.compact
end
