class CreateBlockedUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :blocked_users do |t|
      t.integer :blocked_by
      t.integer :blocked_to

      t.timestamps
    end
  end
end
