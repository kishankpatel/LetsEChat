class CreateUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_groups do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :added_by
      t.integer :removed_by
      t.boolean :is_admin, :default => false

      t.timestamps
    end
  end
end
