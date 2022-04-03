class Blog < ApplicationRecord
  validates :title, :url, presence: true
end
