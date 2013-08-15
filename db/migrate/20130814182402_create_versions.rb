class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :version
      t.string :description
      t.string :author
      t.string :homepage
      t.string :addon_id
    end
  end
end
