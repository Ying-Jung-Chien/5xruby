class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.integer :task_id
      t.string :content

      t.timestamps
    end
  end
end
