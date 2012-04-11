class CreateNavItems < ActiveRecord::Migration
  def change
    create_table :nav_items do |t|
      t.string :title
      t.string :path

      t.timestamps
    end
  end
end
