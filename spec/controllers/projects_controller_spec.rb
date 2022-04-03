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
  # before { allow(controller).to receive(:authenticate_user!).and_return(true) }
  
  let!(:attri) do
    {name: "Title", position: "Position",languages: "[\"ruby\", \"html5\"]", fonts: "[]", colors: "[]", experience: "Experience is long."}
  end

  
  
  
  context "user sign in" do
    
    before { sign_in User.create(email: "test1@test.com", password: "password123")}
    before { post :create, params: { project: attri }}
    
    describe '#create' do
      context "when valid Project" do
        it 'create a new Project' do
          expect(Project.find_by(name: "Title").present?).to eq(true)
        end
        
        it 'redirects to index_path' do
          expect(response).to redirect_to(projects_path)
        end
      end
      
      context "when invalid Project" do
        before do
          attri[:name] = "Invalid Project"
          attri[:position] = ""
          post :create, params: { project: attri }
        end
        
        it "not create new Project" do
          expect(Project.find_by(name: "Invalid Project").present?).to eq(false)
        end
        
      end
    end
  end
  
  describe "#update" do
    
    before { sign_in User.create(email: "test1@test.com", password: "password123")}
    before { post :create, params: { project: attri }}


    it 'update  new Project' do
      project = Project.find_by(name: "Title")
      attri[:name] = "new Title"
      # p params
      put :update , params: { project: attri, id: project.id}
      project.reload
      expect(project.name).to eq("new Title")
    end
  end
end