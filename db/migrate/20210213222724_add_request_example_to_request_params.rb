class AddRequestExampleToRequestParams < ActiveRecord::Migration[6.1]
  def change
    add_reference :request_params, :request_example, null: true, foreign_key: true
    add_reference :request_headers, :request_example, null: true, foreign_key: true
    change_column_null :request_params, :request_id, true
    change_column_null :request_headers, :request_id, true
  end
end
