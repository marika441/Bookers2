class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text :title
      t.text :body
      t.datetime :start_time
      t.integer :user_id
      t.integer :impressions_count, default: 0

      t.timestamps
    end
  end
end
