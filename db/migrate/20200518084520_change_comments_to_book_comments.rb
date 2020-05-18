class ChangeCommentsToBookComments < ActiveRecord::Migration[5.2]
  def change
    rename_table :comments, :book_comments
  end
end
