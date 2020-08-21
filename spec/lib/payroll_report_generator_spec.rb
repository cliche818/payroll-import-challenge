require 'rails_helper'

RSpec.describe PayrollReportGenerator do
  describe '#report' do
    it 'should return a list of employee reports base on EmployeeTime records' do
      EmployeeTime.create(date: Date.new(2020, 1, 4), pay_period_start_date: Date.new(2020, 1, 1), pay_period_end_date: Date.new(2020, 1, 15), hours_worked: 10, employee_id: '1', job_group: 'A')
      EmployeeTime.create(date: Date.new(2020, 1, 14), pay_period_start_date: Date.new(2020, 1, 1), pay_period_end_date: Date.new(2020, 1, 15), hours_worked: 5, employee_id: '1', job_group: 'A')
      EmployeeTime.create(date: Date.new(2020, 1, 4), pay_period_start_date: Date.new(2020, 1, 1), pay_period_end_date: Date.new(2020, 1, 15), hours_worked: 3, employee_id: '2', job_group: 'B')
      EmployeeTime.create(date: Date.new(2020, 1, 20), pay_period_start_date: Date.new(2020, 1, 16), pay_period_end_date: Date.new(2020, 1, 31), hours_worked: 4, employee_id: '1', job_group: 'A')

      report_list = PayrollReportGenerator.new.report

      expect(report_list.size).to eq(3)

      first_report = report_list.first
      expect(first_report.employee_id).to eq('1')
      expect(first_report.pay_period_start_date).to eq(Date.new(2020, 1, 1))
      expect(first_report.pay_period_end_date).to eq(Date.new(2020, 1, 15))
      expect(first_report.amount_paid).to eq(300)

      second_report = report_list[1]
      expect(second_report.employee_id).to eq('1')
      expect(second_report.pay_period_start_date).to eq(Date.new(2020, 1, 16))
      expect(second_report.pay_period_end_date).to eq(Date.new(2020, 1, 31))
      expect(second_report.amount_paid).to eq(80)

      third_report = report_list.last
      expect(third_report.employee_id).to eq('2')
      expect(third_report.pay_period_start_date).to eq(Date.new(2020, 1, 1))
      expect(third_report.pay_period_end_date).to eq(Date.new(2020, 1, 15))
      expect(third_report.amount_paid).to eq(90)
    end
  end
end