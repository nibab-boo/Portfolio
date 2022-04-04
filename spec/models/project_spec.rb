# require 'rails_helper'

# RSpec.describe Class, type: :mvc_type do
#   describe '#method' do
#     it 'description of test' do
#       expect(value).to eq(expected_value)
#     end
#   end
# end

require 'rails_helper'

RSpec.describe Project, type: :model do

  describe '#initialize' do
    context "when valid" do
      it 'returns a created project' do
        project = build(:project)
        expect(project.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it 'returns an invalid project without anything' do
        project = Project.new()
        expect(project.valid?).to eq(false)
      end

      it 'returns an invalid project without name' do
        project = build(:project, name: nil)
        project.valid?
        expect(project.errors.messages).to eq( { name: ["can't be blank"] } )
      end

      it 'returns an invalid project without position' do
        project = build(:project, position: nil)
        project.valid?
        expect(project.errors.messages).to eq({ position: ["can't be blank"] })
      end

      it 'returns an invalid project without experience' do
        project = build(:project, experience: nil)
        project.valid?
        expect(project.errors.messages).to eq( { experience: ["can't be blank"] })
      end

      it 'returns an invalid project without languages' do
        project = build(:project, languages: [])
        project.valid?
        expect(project.errors.messages).to eq({ languages: ["can't be blank"] })
      end
    end
  end


  # for testing method
  # describe '#test_experiment' do
  #   context "valid experiment" do  
  #     it 'returns first 10 letters of experience' do
  #       expect(project.test_experiment).to eq(project.experience[..10])
  #     end
  #   end

  #   context "invalid experiment" do
  #     it "returns an invalid if less than 5" do
  #       project.experience = "Exp"
  #       project.valid?
  #       expect(project.test_experiment).to eq(nil)
  #     end
  #   end
  # end
end