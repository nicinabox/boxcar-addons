class AddFieldsToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :summary, :string
    add_column :packages, :description, :text
  end
end
