class Request < ApplicationRecord
  extend Enumerize
  include Requestable
  
  belongs_to :folder
  belongs_to :certificate, optional: true
  has_many :request_params
  has_many :request_headers
  has_many :request_examples
  has_many :request_logs

  validates_presence_of :name, :method

  enumerize :method, in: [:get, :post, :patch, :put, :delete]
  paginates_per 25

  def all_request_headers
    request_headers
  end

  def all_request_params
    request_params
  end

end
