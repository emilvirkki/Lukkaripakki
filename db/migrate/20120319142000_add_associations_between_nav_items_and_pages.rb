class AddAssociationsBetweenNavItemsAndPages < ActiveRecord::Migration
  def up
    add_column :pages, :nav_item_id, :integer
  end

  def down
    remove_column :pages, :nav_item_id
  end
end
