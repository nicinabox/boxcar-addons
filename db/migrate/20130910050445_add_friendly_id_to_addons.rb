class AddFriendlyIdToAddons < ActiveRecord::Migration
  def change
    add_column :addons, :slug, :string

    add_index :addons,  :slug, unique: true
  end
end
