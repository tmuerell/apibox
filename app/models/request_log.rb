class RequestLog < ApplicationRecord
  belongs_to :request
  belongs_to :request_example, optional: true
end
