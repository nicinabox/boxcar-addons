class AddUserIdToAddons < ActiveRecord::Migration
  def change
    add_column :addons, :user_id, :integer
  end
end
