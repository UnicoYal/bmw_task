class CreateUsersLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :users_lessons do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.boolean :status, default: false
    end
  end
end
