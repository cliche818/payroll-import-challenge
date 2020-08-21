class TimeReportController < ApplicationController
  def create
    file = params[:file]

    report_id = file.original_filename.split('-').last

    if TimeReport.exists?(report_id: report_id)
      render json: {error: "#{file.original_filename} has been uploaded already"} and return
    end  

    unless Dir.exist?(Rails.root.to_s + "/files_storage")
      FileUtils.mkdir(Rails.root.to_s + "/files_storage")
    end

    file_path = Rails.root.to_s + "/files_storage/#{file.original_filename}"

    FileUtils.mv(file.tempfile.path, file_path)
    TimeReportCsvImporter.new.import(file_path)

    time_report = TimeReport.create(
      upload_status: TimeReport.upload_statuses[:success],
      report_id: report_id,
      report_file_name: file.original_filename  
    )
    
    render json: { time_report_id: time_report.id}
  end  
end  