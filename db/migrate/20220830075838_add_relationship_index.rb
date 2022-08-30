class AddRelationshipIndex < ActiveRecord::Migration[7.0]
  def change
    add_index(:tasks, :user_id)
    add_index(:tags, :task_id)
  end
end
