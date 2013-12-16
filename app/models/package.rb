class Package < ActiveRecord::Base
  default_scope { order('slackware_version DESC') }

  class << self
    include PackagesHelper
    def satisfied_packages(params = {})
      package              = Gem::Dependency.new(params[:name], convert_tilde(params[:version]))
      all_package_versions = Package.where name: params[:name]

      all_package_versions.collect { |p|
        db_package = Gem::Dependency.new(p.name, p.version)
        p if package =~ db_package
      }.compact
    end
  end

  def path
    "/slackware-#{slackware_version}#{location}/#{package_name}"
  end

  def url
    "#{packages_host}#{path}"
  end

private

  def packages_host
    "http://slackware.cs.utah.edu/pub/slackware"
  end
end
