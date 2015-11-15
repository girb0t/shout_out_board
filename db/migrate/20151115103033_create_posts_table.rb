class CreatePostsTable < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.belongs_to :category
      t.text :body, null: false

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
