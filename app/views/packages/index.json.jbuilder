json.array!(@packages) do |package|
  json.extract! package, :name, :version, :arch, :build, :package_name,
                         :location, :size_uncompressed, :size_compressed,
                         :slackware_version, :path
end
