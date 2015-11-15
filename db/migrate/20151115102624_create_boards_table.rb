class CreateBoardsTable < ActiveRecord::Migration
  def up
    create_table :boards do |t|
      t.string :key, unique: true, null: false
      t.string :title, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end

  def down
    drop_table :boards
  end
end
