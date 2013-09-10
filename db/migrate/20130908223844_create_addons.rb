class CreateAddons < ActiveRecord::Migration
  def change
    create_table :addons do |t|
      t.string :name
      t.string :endpoint

      t.timestamps
    end
  end
end
