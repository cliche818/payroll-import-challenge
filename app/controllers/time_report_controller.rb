class TimeReportController < ApplicationController
  def create
    file = params[:file]

    unless Dir.exist?(Rails.root.to_s + "/files_storage")
      FileUtils.mkdir(Rails.root.to_s + "/files_storage")
    end

    file_path = Rails.root.to_s + "/files_storage/#{file.original_filename}"

    FileUtils.mv(file.tempfile.path, file_path)
    TimeReportCsvImporter.new.import(file_path)

    report_id = file.original_filename.split('-').last

    TimeReport.create(
      upload_status: TimeReport.upload_statuses[:success],
      report_id: report_id,
      report_file_name: file.original_filename  
    )
    
  end  
end  