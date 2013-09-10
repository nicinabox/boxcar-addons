require 'grit'
require 'httparty'

class Addon < ActiveRecord::Base
  include Grit
  include HTTParty

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :versions

  def latest
    versions.last
  end

  def clone_repo
    dest = tmp_repo(name)

    repo = Git.new(dest)
    repo.clone({
        :quiet => true
      },
      endpoint,
      dest
    )
  end

  def parse_boxcar_json
    dest = tmp_repo(name)
    metadata = dest + "/boxcar.json"

    unless File.exists? metadata
      abort "! No boxcar.json found"
    end

    JSON.parse(File.read(metadata))
  end

  def git_protocol(url)
    if /^git:\/\// =~ url
      true
    end
  end

  def repo_public?(url)
    `git ls-remote #{url}`.include? 'master'
  end

private

  def tmp_repo(name)
    "/tmp/addon/#{name}"
  end
end
