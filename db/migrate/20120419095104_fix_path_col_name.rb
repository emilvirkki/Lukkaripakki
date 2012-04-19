class FixPathColName < ActiveRecord::Migration
  def up
    rename_column :nav_items, :path, :explicit_path
  end

  def down
  end
end
