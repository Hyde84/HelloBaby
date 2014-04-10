class AddUserIdToAudios < ActiveRecord::Migration
  def up
    add_column :audios, :user_id, :integer
  end
  def down
    remove_column :audios, :user_id
  end
end
