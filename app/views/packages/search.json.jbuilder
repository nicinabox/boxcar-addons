packages = @packages.collect { |p| p.name }.uniq

json.array!(packages) do |package_name|
  json.name package_name
  json.versions @packages.collect { |p|
                  p.version if p.name == package_name
                }.compact
end
