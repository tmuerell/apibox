class CreateRequestExamples < ActiveRecord::Migration[6.1]
  def change
    create_table :request_examples do |t|
      t.references :request, null: false, foreign_key: true
      t.string :name
      t.string :content_type
      t.text :body

      t.timestamps
    end
  end
end
