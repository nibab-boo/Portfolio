require 'rails_helper'

RSpec.describe Blog, type: :model do


  describe '#initialize' do

    let(:attri) {puts "horllo"
       {title: "Title", url: "www.url.com", languages: ["rails", "rspec"] } }

    context "valid params" do
      it 'returns a valid blog with languages' do
        blog = Blog.new(attri)
        p blog
        expect(blog.valid?).to eq(true)
      end

      it 'returns a valid blog without languages' do
        attri[:languages] = []
        blog = Blog.new(attri)
        expect(blog.valid?).to eq(true)
      end
    end

    context "invalid params" do
      
    end
  end
end