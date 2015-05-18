class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :content, null: false
      t.boolean :is_private, null: false, default: false
      t.integer :user_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
