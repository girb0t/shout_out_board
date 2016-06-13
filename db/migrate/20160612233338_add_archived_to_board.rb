class AddArchivedToBoard < ActiveRecord::Migration
  def up
    add_column :boards, :archived, :boolean, default: false
  end

  def down
    remove_column :boards, :archived
  end
end
