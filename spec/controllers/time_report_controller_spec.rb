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

      json = JSON.parse(response.body)
      expect(json["time_report_id"]).to eq(time_report.id)
    end

    it 'should return an error message if the file has already been uploaded' do
      TimeReport.create(upload_status: 'success', report_id: 10, report_file_name: 'time-report-10.csv')
      file = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/time-report-10.csv", 'text/csv')

      post :create, params: { file: file }

      json = JSON.parse(response.body)
      expect(json["error"]).to eq('time-report-10.csv has been uploaded already')
      expect(response.status).to eq(400)
    end

    it 'should return an error message if the file does not conform to the expected fileanem time-report-x.csv' do
      file = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/bad-name-report.csv", 'text/csv')

      post :create, params: { file: file }

      json = JSON.parse(response.body)
      expect(json["error"]).to eq('Filename should be named time-report-ID.csv, ID being integer')
      expect(response.status).to eq(400)
    end
  end
end    