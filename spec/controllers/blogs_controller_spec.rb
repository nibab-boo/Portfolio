require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  

  context " user signed_in " do

    before { sign_in create(:user) }

    describe "#journey" do
      before { get :journey }

      it "access to index" do
        expect(response).to be_successful
      end

      it "render blogs/journey.html.erb" do
        expect(response).to render_template(:journey)
      end

      it "passing a json" do
        expect(assigns(:json).class).to be(Hash)
      end

      it "passes blogs with old at last" do
        expect(assigns(:blogs).to_a).to match_array(Blog.order(id: :desc))
      end
    end

    describe "#new" do
      before { get :new }
      # renders new
      it "render blogs/new" do
        expect(response).to render_template(:new)
      end

      # no instance variable
      it "new instance variable" do
        expect(assigns(:blog).id).to be(nil) 
      end
    end

    describe "#create" do
            
      context "when valid params" do
        before { post :create, params: { blog: attributes_for(:blog, url: "www.test.com") } }
        
        it "creates a new blog" do
          expect(Blog.find_by(title: "Title").url).to eq("www.test.com")
        end

        it "redirects to journey_path" do
          expect(response).to redirect_to(journey_path)
        end

        # count increased by one
        it "increase count by 1" do
          expect do
            post :create, params: { blog: attributes_for(:blog) }
          end.to change{ Blog.count }.by(1)
        end
      end

      context "when invalid params" do

        before { post :create, params: { blog: attributes_for(:blog, url: "") } }
        # not create a new blogs
        it "not create new blogs" do
          expect(Blog.find_by(title: "Title").present?).to be(false)
        end

        # render :new
        it "renders blogs/new" do
          expect(response).to render_template(:new)
        end

        # count not changed
        it "not change count" do
          expect{post :create, params: {blog: attributes_for(:blog, title: "")} }.not_to change{ Blog.count }
        end
      end
    end

    describe "#edit" do
      before do
        post :create, params: { blog: attributes_for(:blog, url: "www.test.com") } 
        get :edit, params: { id: Blog.find_by(url: "www.test.com") }
      end
      
      # should have saved blog
      it "have saved blog instance" do
        expect(assigns(:blog).id.present?).to be(true)
      end

      it "should render edit" do
        expect(response).to render_template(:edit)
      end
    end

    describe "#update" do
      before { post :create, params: { blog: attributes_for(:blog, url: "www.test.com") } }

      let!(:blog) { Blog.find_by(url: "www.test.com") }

      context "when valid params" do
        subject do
          put :update, params: { blog: attributes_for(:blog) , id: blog.id}
          blog.reload    
        end 

        # it updates
        it "should update blog" do
          subject
          expect(blog.url).to eq("www.url.com")
        end
        # redirects to journey_path
        it "redirects to journey_path" do
          subject
          expect(response).to redirect_to(journey_path)
        end
        # doesnot change the count of blog
        it "not change count" do
          expect{subject}.not_to change{ Blog.count } 
        end
      end 
      
      context "when invalid params" do
        subject do
          put :update, params: { blog: attributes_for(:blog, title: "new Title", url: ""), id: blog.id}
          blog.reload
        end

        # doesnot change blog
        it "not change blog" do
          subject
          expect(blog.title).to eq("Title")
        end
        # renders to blog/edit
        it "renders blog/edit" do
          subject
          expect(response).to render_template(:edit)
        end

        # not change count
        it "not change count" do
          expect{subject}.not_to change{ Blog.count }
        end
      end
    end

  end

  context " user sign_out " do
    
  end
end
