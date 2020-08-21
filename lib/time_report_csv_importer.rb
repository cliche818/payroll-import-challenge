require 'csv'

class TimeReportCsvImporter
  def import(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      date = Date.parse(row["date"])
      if date.day <= 15
        pay_period_start_date = Date.new(date.year, date.month, 1)
        pay_period_end_date = Date.new(date.year, date.month, 15)
      else
        pay_period_start_date = Date.new(date.year, date.month, 16)
        pay_period_end_date = Date.new(date.year, date.month, -1)  
      end  

      employee_time = EmployeeTime.new(
        date: date,
        pay_period_start_date: pay_period_start_date,
        pay_period_end_date: pay_period_end_date,
        hours_worked: row["hours worked"],
        employee_id: row["employee id"],
        job_group: row["job group"] 
      )

      employee_time.save!
    end
  end  
end  