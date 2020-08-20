require 'csv'

class TimeReportCsvImporter
  def import(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      raw_employee_time = RawEmployeeTime.new(
        date: row["date"],
        hours_worked: row["hours worked"],
        employee_id: row["employee id"],
        job_group: row["job group"] 
      )

      raw_employee_time.save!
    end
  end  
end  