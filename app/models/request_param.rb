class RequestParam < ApplicationRecord
  belongs_to :request, optional: true
  belongs_to :request_example, optional: true
end
