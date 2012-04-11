class AddAncestryToNavItems < ActiveRecord::Migration
  def change
    add_column :nav_items, :ancestry, :string
    add_index :nav_items, :ancestry
  end
end
