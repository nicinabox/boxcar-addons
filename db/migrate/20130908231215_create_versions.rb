class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :author
      t.string :number
      t.text :description
      t.integer :addon_id
      t.string :licenses
      t.text :dependencies
      t.string :homepage

      t.timestamps
    end
  end
end
