class AddColorColsToPosts < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE posts
      ADD COLUMN background_color_hex VARCHAR(7),
      ADD COLUMN font_color_hex VARCHAR(7);
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE posts
      DROP COLUMN background_color_hex,
      DROP COLUMN font_color_hex;
    SQL
  end
end
