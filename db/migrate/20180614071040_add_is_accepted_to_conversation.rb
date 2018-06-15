class AddIsAcceptedToConversation < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :is_accepted, :boolean, :default => false
  end
end
