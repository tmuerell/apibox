class Request < ApplicationRecord
  extend Enumerize
  
  belongs_to :folder
  belongs_to :certificate, optional: true
  has_many :request_params
  has_many :request_headers

  enumerize :method, in: [:get, :post, :patch, :put, :delete]
  paginates_per 25

  def lang
    if content_type =~ /application\/json/
      "json"
    else
      ""
    end
  end
end
