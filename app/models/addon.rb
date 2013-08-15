class Addon < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :versions

  def latest_version
    versions.last || []
  end
end
