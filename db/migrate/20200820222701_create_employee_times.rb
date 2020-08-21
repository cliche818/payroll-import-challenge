class CreateEmployeeTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :employee_times do |t|
      t.date :date
      t.date :pay_period_start_date
      t.date :pay_period_end_date
      t.float :hours_worked
      t.string :employee_id
      t.string :job_group
      t.timestamps
    end
  end
end
