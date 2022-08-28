class AddIndex < ActiveRecord::Migration[7.0]
  def change
    add_index(:tasks, :header)
    add_index(:tasks, :content)
    add_index(:tasks, :status)
  end
end
