module ValueObjects
  class EmployeePeriodPayrollReport < Struct.new(:employee_id, :pay_period_start_date, :pay_period_end_date, :amount_paid, keyword_init: true)
      
  end  
end  