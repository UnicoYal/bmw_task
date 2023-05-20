class AddAtributesForLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :title, :string
    add_column :lessons, :part_fr, :text
    add_column :lessons, :part_sc, :text
    add_column :lessons, :main, :text
  end
end
