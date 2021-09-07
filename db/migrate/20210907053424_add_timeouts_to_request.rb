class AddTimeoutsToRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :timeout, :integer, default: 30, null: false
    add_column :requests, :open_timeout, :integer, default: 30, null: false
  end
end
