class User < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        change_column :users, :name, :string, null: false
        change_column :users, :password, :string, null: false
        change_column :users, :position, :string, null: false
      end
      dir.down do
        change_column :users, :name, :string
        change_column :users, :password, :string
        change_column :users, :position, :string
      end
    end
  end
end
