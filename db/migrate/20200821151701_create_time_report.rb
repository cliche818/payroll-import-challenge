class CreateTimeReport < ActiveRecord::Migration[6.0]
  def change
    create_table :time_reports do |t|
      t.string :report_file_name
      t.integer :report_id
      t.string :upload_status
      t.timestamps
    end
  end
end
