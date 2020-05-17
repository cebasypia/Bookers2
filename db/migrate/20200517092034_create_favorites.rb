class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps

      t.index :user_id
      t.index :book_id
      t.index [:user_id, :book_id], unique: true
    end
  end
end
