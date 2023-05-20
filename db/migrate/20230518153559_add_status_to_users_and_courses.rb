class AddStatusToUsersAndCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses_users, :status, :boolean, default: false
  end
end
