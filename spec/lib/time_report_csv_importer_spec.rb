require 'rails_helper'

RSpec.describe "Time Report CSV Importer" do
  describe "#run" do
    it "should create RawEmployeeTimes" do
      file_path = Rails.root.to_s + "/spec/fixtures/time-report-1.csv"
      TimeReportCsvImporter.new.import(file_path)

      expect(RawEmployeeTime.count).to eq(3)

      first_employee_time = RawEmployeeTime.first
      expect(first_employee_time.date).to eq(DateTime.parse('14/11/2016'))
      expect(first_employee_time.hours_worked).to eq(7.5)
      expect(first_employee_time.employee_id).to eq('1')
      expect(first_employee_time.job_group).to eq('A')
    end
  end
end