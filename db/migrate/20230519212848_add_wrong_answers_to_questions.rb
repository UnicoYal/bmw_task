class AddWrongAnswersToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :wrong_first, :string
    add_column :questions, :wrong_second, :string
  end
end
