class AddExperiencePointToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :experience_point, :integer, default: 0
  end
end
