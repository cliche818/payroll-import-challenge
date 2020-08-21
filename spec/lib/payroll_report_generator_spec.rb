require 'rails_helper'

RSpec.describe PayrollReportGenerator do
  describe '#report' do
    it 'should return a list of employee reports base on EmployeeTime records' do
      EmployeeTime.create(date: Date.new(2020, 1, 4), pay_period_start_date: Date.new(2020, 1, 1), pay_period_end_date: Date.new(2020, 1, 15), hours_worked: 10, employee_id: '1', job_group: 'A')
      EmployeeTime.create(date: Date.new(2020, 1, 14), pay_period_start_date: Date.new(2020, 1, 1), pay_period_end_date: Date.new(2020, 1, 15), hours_worked: 5, employee_id: '1', job_group: 'A')
      EmployeeTime.create(date: Date.new(2020, 1, 4), pay_period_start_date: Date.new(2020, 1, 1), pay_period_end_date: Date.new(2020, 1, 15), hours_worked: 3, employee_id: '2', job_group: 'A')
      EmployeeTime.create(date: Date.new(2020, 1, 20), pay_period_start_date: Date.new(2020, 1, 16), pay_period_end_date: Date.new(2020, 1, 31), hours_worked: 4, employee_id: '1', job_group: 'A')

      report_list = PayrollReportGenerator.new.report

      expect(report_list.size).to eq(3)
    end
  end
end