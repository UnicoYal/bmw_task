class AddPatronymicToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :patronymic, :string
  end
end
