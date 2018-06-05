class CreateTempImages < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_images do |t|
      t.attachment :image
      t.integer :user_id

      t.timestamps
    end
  end
end
