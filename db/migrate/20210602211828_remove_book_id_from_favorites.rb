class RemoveBookIdFromFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :book_id, :string
  end
end
