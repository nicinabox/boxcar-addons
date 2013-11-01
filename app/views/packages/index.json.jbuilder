json.array!(@packages) do |package|
  json.extract! package, :name, :version, :arch, :build, :summary,
                         :description, :package_name,
                         :location, :size_uncompressed, :size_compressed,
                         :slackware_version, :path
end
