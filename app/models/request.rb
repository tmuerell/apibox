class Request < ApplicationRecord
  extend Enumerize
  
  belongs_to :folder
  belongs_to :certificate, optional: true

  enumerize :method, in: [:get, :post, :patch, :put, :delete]
end
