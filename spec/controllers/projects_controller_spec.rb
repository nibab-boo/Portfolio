# require 'rails_helper'

# RSpec.describe Class, type: :mvc_type do
#   describe '#method' do
#     it 'description of test' do
#       expect(value).to eq(expected_value)
#     end
#   end
# end


require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  # test prevent authenticate_user!
  before { allow(controller).to receive(:authenticate_user!).and_return(true) }
  
  let!(:attri) do
    {name: "Title", position: "Position",languages: "[\"ruby\", \"html5\"]", fonts: "[]", colors: "[]", experience: "Experience is long."}
  end

  before { post :create, params: { project: attri }}

  describe '#create' do
    it 'create a new task' do
      expect(Project.find_by(name: "Title").present?).to eq(true);
    end
  end
  
  describe "#update" do
    it 'update  new task' do
      project = Project.find_by(name: "Title")
      attri[:name] = "new Title"
      # p params
      put :update , params: { project: attri, id: project.id}
      project.reload
      expect(project.name).to eq("new Title")
    end
  end
end