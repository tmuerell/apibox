class CreateCertificates < ActiveRecord::Migration[6.1]
  def change
    create_table :certificates do |t|
      t.string :name
      t.text :cert
      t.text :key

      t.timestamps
    end
  end
end
