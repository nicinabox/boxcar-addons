class Package < ActiveRecord::Base
  def path
    "/slackware-#{slackware_version}#{location}/#{package_name}"
  end
end
