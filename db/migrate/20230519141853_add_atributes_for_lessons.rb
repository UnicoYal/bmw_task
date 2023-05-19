class AddAtributesForLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :title, :string
    add_column :lessons, :part_fr, :test
    add_column :lessons, :part_sc, :test
    add_column :lessons, :main, :text
  end
end
