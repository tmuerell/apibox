class CreateRequestLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :request_logs do |t|
      t.references :request, null: false, foreign_key: true
      t.text :outgoing_data
      t.text :incoming_data
      t.integer :status_code
      t.string :request_identifier

      t.timestamps
    end
  end
end
