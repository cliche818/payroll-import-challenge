class PayrollReportGenerator
  def report
    grouped_employee_times = EmployeeTime
    .select(:employee_id, :job_group, :pay_period_start_date, :pay_period_end_date, "SUM(hours_worked) as total_hours")
    .group(:employee_id, :job_group, :pay_period_start_date, :pay_period_end_date)

    report_list = []
    grouped_employee_times.each do |group_employee_time|
      report_list << ValueObjects::EmployeePeriodPayrollReport.new(
        employee_id: group_employee_time.employee_id, 
        pay_period_start_date: group_employee_time.pay_period_start_date, 
        pay_period_end_date: group_employee_time.pay_period_end_date, 
        amount_paid: calculate_amount_paid(group_employee_time.job_group, group_employee_time.total_hours)
      )
    end
    
    report_list
  end

  private

  def calculate_amount_paid(job_group, hours_worked)
    if job_group == 'A'
      hours_worked * 20
    elsif job_group == 'B'
      hours_worked * 30  
    end  
  end
end  