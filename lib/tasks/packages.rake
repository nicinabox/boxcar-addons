# require 'package'
require 'httparty'

def host
  'http://slackware.cs.utah.edu/pub/slackware'
end

def packages_txt(slackware_version)
  "/slackware-#{slackware_version}/PACKAGES.TXT"
end

namespace :packages do
  desc "Parse and import mirror package data"
  task :import, [:slackware_version] => [:environment] do |t, args|
    slackware_version = args[:slackware_version]

    raw_packages = HTTParty.get("#{host}#{packages_txt(slackware_version)}")
    packages = raw_packages.scan(/(PACKAGE NAME.+?)\n\n/m)

    packages.flatten.each do |package|
      package_name = package.match(/PACKAGE NAME:(.+)/)[1].strip
      location     = package.match(/PACKAGE LOCATION:\s+\.(.+)/)[1].strip
      comp, uncomp = package.scan(/PACKAGE SIZE.+:(.+)/).flatten.map(&:strip)
      raw_summary  = package.match(/PACKAGE DESCRIPTION:(.+)/m)[1].strip

      name, version, arch, build = package_name.scan(/(.+)-(.+)-(.+)-(.+)\./).flatten

      # Note to future self: aalib will FUCK YOU UP
      next if name == 'aalib'

      # Remove name prefix
      description = raw_summary.gsub("#{name}:", "")

      # Split summary
      summary = description.slice!(/^(.+)\n/).strip

      # Cleanup description
      description = description.gsub(/\n /, " ").gsub("  ", " ").strip

      puts "#{name} (#{version}) - #{summary}"
      @package = Package.create!(
        :name => name,
        :version => version,
        :arch => arch,
        :build => build,
        :package_name => package_name,
        :location => location,
        :size_compressed => comp,
        :size_uncompressed => uncomp,
        :slackware_version => slackware_version,
        :summary => summary,
        :description => description
      )
    end

  end
end
