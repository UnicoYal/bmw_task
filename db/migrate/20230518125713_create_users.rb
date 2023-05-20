class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :second_name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.integer :role, default: 0

    end
  end
end
