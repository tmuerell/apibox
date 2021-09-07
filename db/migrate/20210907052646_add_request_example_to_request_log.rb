class AddRequestExampleToRequestLog < ActiveRecord::Migration[6.1]
  def change
    add_reference :request_logs, :request_example, null: true, foreign_key: true
  end
end
