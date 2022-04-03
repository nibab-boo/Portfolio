class Project < ApplicationRecord
  has_many_attached :photos

  validates :name, :position, :experience, :languages, presence: true
  # validates :name, presence: true
  validates :experience, length: { minimum: 10 }
  
  # for testing method
  # def test_experiment
  #   if experience.length > 5
  #     return experience[..10]
  #   end
  #   nil
  # end
end
