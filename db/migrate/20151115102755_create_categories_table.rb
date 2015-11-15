class CreateCategoriesTable < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.belongs_to :board
      t.string :title
      t.string :prompt

      t.timestamps
    end

    def down
      drop_table :categories
    end
  end
end
