class CreateGroupMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :group_messages do |t|
      t.text     "body"
      t.integer  "user_id"
      t.integer  "group_id"
      t.timestamps
    end
    add_index :group_messages, [:user_id, :group_id]
  end
end