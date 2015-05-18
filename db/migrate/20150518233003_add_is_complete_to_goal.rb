class AddIsCompleteToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :is_complete, :boolean, default: false, null: false
  end
end
