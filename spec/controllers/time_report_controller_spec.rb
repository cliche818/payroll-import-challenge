require 'rails_helper'

RSpec.describe TimeReportController do
  describe '#create' do
    it 'should create a time report record if the file is successfully uploaded' do
      file = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/time-report-10.csv", 'text/csv')

      expect_any_instance_of(TimeReportCsvImporter).to receive(:import)

      post :create, params: { file: file }

      expect(TimeReport.count).to eq(1)

      time_report = TimeReport.first
      expect(time_report.upload_status).to eq('success')
      expect(time_report.report_id).to eq(10)
      expect(time_report.report_file_name).to eq('time-report-10.csv')
    end
  end
end    