require 'grit'
require 'httparty'

class Addon < ActiveRecord::Base
  include Grit
  include HTTParty
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
  validates_uniqueness_of :name

  validate :git_protocol
  validate :public_repo
  validate :boxcar_json_exists

  has_many :versions, dependent: :destroy
  belongs_to :user

  def latest
    versions.last
  end

  def human_name
    latest.name or name
  end

  # This really doesn't belong here
  def clone_repo
    dest = tmp_repo

    repo = Git.new(dest)
    repo.clone({ :quiet => true }, endpoint, dest)
  end

  def manifest
    raw_boxcar_json.reject { |k, v|
      Version.attribute_names.exclude?(k) and
      Version.attribute_aliases.exclude?(k)
    }
  end

  def dependency_urls
    latest.dependencies.map { |d| to_slackware_url(d) }
  end

private

  def to_slackware_url(dependency)
    package = Package.find_by_name dependency.first
    package.url
  end

  def raw_boxcar_json
    if File.exists? boxcar_json
      p JSON.parse(File.read(boxcar_json))
    else
      {}
    end
  end

  def boxcar_json
    tmp_repo << "/boxcar.json"
  end

  def boxcar_json_exists
    unless File.exists? boxcar_json
      errors.add(:endpoint, "must include boxcar.json")
    end
  end

  def public_repo
    unless `git ls-remote #{endpoint}`.include? 'master'
      errors.add(:endpoint, "must be a public repo")
    end
  end

  def git_protocol
    unless /^git:\/\// =~ endpoint
      errors.add(:endpoint, "must use git:// protocol")
    end
  end

  def tmp_repo
    "#{Rails.root}/tmp/addon/#{name}"
  end
end
