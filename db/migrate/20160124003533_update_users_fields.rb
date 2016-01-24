class UpdateUsersFields < ActiveRecord::Migration
  def up
    remove_column :users, :email
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
  end

  def down
    add_column :users, :email, :string, unique: true, null: false
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
