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

      name, version, arch, build = package_name.scan(/([a-z\-_?]+)-([\w\.]+)-(i\d86|x86_64|noarch)-([\d]+)/).flatten

      @package = Package.create!(
        :name => name,
        :version => version,
        :arch => arch,
        :build => build,
        :package_name => package_name,
        :location => location,
        :size_compressed => comp,
        :size_uncompressed => uncomp,
        :slackware_version => slackware_version
      )
    end

  end
end
