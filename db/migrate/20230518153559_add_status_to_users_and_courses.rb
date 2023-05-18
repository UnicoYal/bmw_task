class AddStatusToUsersAndCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :users_and_courses, :status, :boolean, default: false
  end
end
