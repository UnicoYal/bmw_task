class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :all_courses
      t.integer :finished_courses

      t.timestamps
    end
  end
end
