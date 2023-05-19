class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.integer :course_id
      t.integer :number

      t.timestamps
    end
  end
end
