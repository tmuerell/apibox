class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', optional: true
  has_many :requests
  acts_as_tree order: "name"
end
