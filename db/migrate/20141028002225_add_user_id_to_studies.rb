class AddUserIdToStudies < ActiveRecord::Migration
  def change
    add_column :studies, :user_id, :integer, null: false
  end
end
