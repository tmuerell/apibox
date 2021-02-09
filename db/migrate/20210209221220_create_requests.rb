class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :url
      t.string :method
      t.string :content_type
      t.text :body
      t.references :folder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
