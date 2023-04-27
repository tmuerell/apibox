class RequestExample < ApplicationRecord
  include Requestable
  
  delegate :certificate, :url, :method, to: :request

  belongs_to :request
  has_many :request_params, dependent: :destroy
  has_many :request_headers, dependent: :destroy
  has_many :request_logs, dependent: :destroy

  validates_presence_of :name

  def all_request_headers
    request.request_headers + request_headers
  end

  def all_request_params
    request_params
  end
end