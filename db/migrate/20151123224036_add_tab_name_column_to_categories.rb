class AddTabNameColumnToCategories < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE categories
      ADD COLUMN tab_name VARCHAR NOT NULL;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE categories
      DROP COLUMN tab_name;
    SQL
  end
end
