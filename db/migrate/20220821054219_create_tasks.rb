class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :header
      t.text :content
      t.integer :priority
      t.integer :status
      t.timestamp :start
      t.timestamp :end

      t.timestamps
    end
  end
end
