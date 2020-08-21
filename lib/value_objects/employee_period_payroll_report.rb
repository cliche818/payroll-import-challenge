module ValueObjects
  class EmployeePeriodPayrollReport < Struct.new(:employee_id, :pay_period_start_date, :pay_period_end_date, :amount_paid, keyword_init: true)
      def to_json
        {
          "employeeId": employee_id,
          "payPeriod": {
            "startDate": pay_period_start_date.strftime('%F'),
            "endDate": pay_period_end_date.strftime('%F')
          },
          "amountPaid": amount_paid.format
        }
      end  
  end  
end  