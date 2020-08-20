class CreateRawEmployeeTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :raw_employee_times do |t|
      t.datetime :date
      t.float :hours_worked
      t.string :employee_id
      t.string :job_group
    end
  end
end
