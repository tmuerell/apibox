class AddCertificateToRequest < ActiveRecord::Migration[6.1]
  def change
    add_reference :requests, :certificate, null: true, foreign_key: true
  end
end
