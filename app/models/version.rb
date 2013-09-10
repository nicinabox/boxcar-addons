class Version < ActiveRecord::Base
  belongs_to :addon

  serialize :dependencies

  alias_attribute :version, :number
end
