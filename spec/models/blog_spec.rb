require 'rails_helper'

RSpec.describe Blog, type: :model do


  describe '#initialize' do

    let(:attri) { {title: "Title", url: "www.url.com", languages: ["rails", "rspec"] } }

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
      it 'returns a invalid blog without title' do
        attri[:title] = ""
        blog = Blog.new(attri)
        blog.valid?
        expect(blog.errors.messages).to eq( {title: ["can't be blank"]})
      end

      it 'returns a invalid blog without url' do
        attri[:url] = ""
        blog = Blog.new(attri)
        blog.valid?
        expect(blog.errors.messages).to eq({ url: ["can't be blank"]})
      end
    end
  end
end