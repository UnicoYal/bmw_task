class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :part_fr
      t.text :part_sc
      t.text :main

      t.timestamps
    end
  end
end
