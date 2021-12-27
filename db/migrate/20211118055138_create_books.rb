class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text :title
      t.text :body
      # カレンダーに出力させる
      t.datetime :start_time
      t.integer :user_id

      t.timestamps
    end
  end
end
