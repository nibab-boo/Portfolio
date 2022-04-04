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

  let(:user) { create(:user) }
  
  context "user siged_in" do
    # sign in as user
    before { sign_in user }
    # create a post
    
    describe "#index" do
      it "access to index" do
        get :index
        
        # p response.successful?
        
        expect(response).to be_successful
      end

        it "renders projects/index.html.erb" do
          get :index
          expect(response).to render_template(:index)
        end
    end
    
    describe "#new" do
      it "give a new project" do
        get :new
        
        # p (assigns(:project))
        expect(assigns(:project)).to be_a_new(Project)
      end
    end
    
      
    describe '#create' do
      before { post :create, params: { project: attri }}
      
      context "when valid Project" do
        it 'create a new Project' do
          expect(Project.find_by(name: "Title").present?).to eq(true)
        end
        
        it 'redirects to index_path' do
          expect(response).to redirect_to(projects_path)
        end

        it 'increase count by 1' do
          expect { post :create, params: { project: attri }}.to change{Project.count}.by(1)
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
        
        # render new
        it "render projects/new" do
          expect(response).to render_template(:new)
        end
      end
    end

    describe "#edit" do
      before { post :create, params: { project: attri }}
      
      it "return valid project" do
        project = Project.find_by(name: "Title")
        get :edit, params: { id: project.id }

        expect(assigns(:project)  ).to eq(project)
      end
    end
    
    describe "#update" do
      before { post :create, params: { project: attri }}
      
      let!(:project) { Project.find_by(name: "Title") }

      context "valid params" do
        
        # subject for counter
        subject do 
            attri[:name] = "new Title"
            # p params
            put :update , params: { project: attri, id: project.id}
            project.reload
        end

        it 'update Project' do
          subject
          expect(project.name).to eq("new Title")
        end

        it "count not increased" do
          expect{subject}.not_to change{ Project.count }
        end

        it "redirects to index_path" do
          subject
          expect(response).to redirect_to(projects_path)
        end

      end

      context "invalid params" do
        before do
          attri[:position] = ""
          put :update , params: { project: attri, id: project.id}
          project.reload
        end

        it "not update" do
          expect(project.position).to eq("Position")
        end

        it "render project/edit" do
          expect(response).to render_template(:edit)
        end 
      end
    end
  end

  context "user not signed_in" do
    before { sign_in nil }

    describe "#index" do
      it "access to index" do
        get :index
        expect(response).to be_successful
      end

      it "renders projects/index.html.erb" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "#new" do
      it "not render new" do
        get :new
        expect(response).not_to render_template(:new)
      end

      it "redirects to log_in" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end

      it "no project instance" do
        get :new
        expect(assigns(:project)).to eq(nil)
      end
    end

    describe "#create" do

      it "no project created" do
        expect{ post :create, params: { project: attri }}.not_to change{ Project.count }
      end

      it "redirects to log_in" do
        post :create, params: { project: attri }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "#edit" do
      before do
        sign_in user
        post :create, params: { project: attri }
        sign_in nil
        get :edit, params: { id: Project.find_by(name: "Title").id }
      end

      it "redirects to log_in" do
        expect(response).to redirect_to(new_user_session_path)
      end

      it "not render project/edit" do
        expect(response).not_to render_template(:edit)        
      end

    end

    describe "#update" do
      before do
        sign_in user
        post :create, params: { project: attri }
        sign_in nil
        attri[:position] = "New Position"
        put :update, params: { project: attri, id: Project.find_by(name: "Title").id }
      end

      # should not update project
      it "not update project" do
        expect(assigns(:project).position).to eq("Position")
      end

      # should redirect_to sign_in
      it "redirect to sign_in" do
        expect(response).to redirect_to(new_user_session_path)
      end

      # should not redirect_to projects_path
      it "not redirect_to projects_path" do
        expect(response).not_to redirect_to(projects_path)
      end
    end
  end
end