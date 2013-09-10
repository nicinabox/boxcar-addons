class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.string :arch
      t.string :build
      t.string :package_name
      t.string :location
      t.string :size_uncompressed
      t.string :size_compressed
      t.string :slackware_version

      t.timestamps
    end
  end
end
