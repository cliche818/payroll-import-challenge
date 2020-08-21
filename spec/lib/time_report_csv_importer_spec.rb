require 'rails_helper'

RSpec.describe "Time Report CSV Importer" do
  describe "#run" do
    it "should create RawEmployeeTimes" do
      file_path = Rails.root.to_s + "/spec/fixtures/time-report-1.csv"
      TimeReportCsvImporter.new.import(file_path)

      expect(EmployeeTime.count).to eq(3)

      first_employee_time = EmployeeTime.first
      expect(first_employee_time.date).to eq(Date.parse('14/11/2016'))
      expect(first_employee_time.hours_worked).to eq(7.5)
      expect(first_employee_time.employee_id).to eq('1')
      expect(first_employee_time.job_group).to eq('A')
    end

    it 'should set the correct pay_period_start_date and pay_period_end_date in the first half of the month' do
      file_path = Rails.root.to_s + "/spec/fixtures/time-report-2.csv"
      TimeReportCsvImporter.new.import(file_path)

      expect(EmployeeTime.count).to eq(1)

      first_employee_time = EmployeeTime.first
      expect(first_employee_time.pay_period_start_date).to eq(Date.parse('1/11/2016'))
      expect(first_employee_time.pay_period_end_date).to eq(Date.parse('15/11/2016'))
    end

    it 'should set the correct pay_period_start_date and pay_period_end_date in the end half of the path' do
      file_path = Rails.root.to_s + "/spec/fixtures/time-report-3.csv"
      TimeReportCsvImporter.new.import(file_path)

      expect(EmployeeTime.count).to eq(1)

      first_employee_time = EmployeeTime.first
      expect(first_employee_time.pay_period_start_date).to eq(Date.parse('16/11/2016'))
      expect(first_employee_time.pay_period_end_date).to eq(Date.parse('30/11/2016'))
    end
  end
end