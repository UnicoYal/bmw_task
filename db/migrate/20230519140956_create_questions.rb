class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :test_id
      t.integer :num
      t.string :question
      t.string :answer

    end
  end
end
