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

  let!(:project) { Project.new(name: "Title", position: "Position", experience: "Experience should be greater than 10 letters long", languages: ["rails", "rspec"]) }

  describe '#initialize' do
    context "when valid" do
      it 'returns a created project' do
        expect(project.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it 'returns an invalid project without anything' do
        project = Project.new()
        expect(project.valid?).to eq(false)
      end

      it 'returns an invalid project without title' do
        # project = Project.new()
        project = Project.new(position: "Position", experience: "Experience", languages: ["rails", "rspec"])
        project.valid?
        expect(project.errors.messages).to eq( { name: ["can't be blank"] } )
      end

      it 'returns an invalid project without position' do
        project = Project.new(name: "Title", experience: "Experience", languages: ["rails", "rspec"])
        project.valid?
        expect(project.errors.messages).to eq({ position: ["can't be blank"] })
      end

      context "invalid experience" do
        before { project.experience = "Expert"}
        it 'returns an invalid project with experience less than 10 letters long' do
          project.valid?
          expect(project.errors.messages).to eq( { experience: ["is too short (minimum is 10 characters)"] })
        end

        it 'returns an invalid project without experience' do
          project.experience = nil
          project.valid?
          expect(project.errors.messages).to eq( { experience: ["can't be blank",
                                                               "is too short (minimum is 10 characters)"] })
        end

      end

      it 'returns an invalid project without languages' do
        project = Project.new(name: "Title", position: "Position", experience: "Experience")
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