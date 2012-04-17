class AddPriorityToNavItems < ActiveRecord::Migration
  def change
    add_column :nav_items, :priority, :integer
  end
end
