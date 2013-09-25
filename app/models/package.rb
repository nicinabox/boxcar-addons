class Package < ActiveRecord::Base
  default_scope order('slackware_version DESC')

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
