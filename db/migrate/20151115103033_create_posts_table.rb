class CreatePostsTable < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.belongs_to :categories
      t.text :body, null: false

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
