class AddPointToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :point, :integer
  end
end
