class RequestParam < ApplicationRecord
  belongs_to :request, optional: true
  belongs_to :request_example, optional: true

  validate :belongs_to_request_or_example

  protected

  def belongs_to_request_or_example
    unless self.request.present? or self.request_example.present?
      self.errors.add :request, 'Associated object not found'
    end
  end
end
