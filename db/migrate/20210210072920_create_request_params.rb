class CreateRequestParams < ActiveRecord::Migration[6.1]
  def change
    create_table :request_params do |t|
      t.references :request, null: false, foreign_key: true
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
