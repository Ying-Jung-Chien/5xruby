class Task < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        change_column :tasks, :header, :string, null: false
        change_column :tasks, :content, :text, null: false
        change_column :tasks, :priority, :integer, null: false
        change_column :tasks, :status, :integer, null: false
        change_column :tasks, :start_time, :timestamp, null: false
        change_column :tasks, :end_time, :timestamp, null: false
      end
      dir.down do
        change_column :tasks, :header, :string
        change_column :tasks, :content, :text
        change_column :tasks, :priority, :integer
        change_column :tasks, :status, :integer
        change_column :tasks, :start_time, :timestamp
        change_column :tasks, :end_time, :timestamp
      end
    end
  end
end
