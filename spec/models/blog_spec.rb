require 'rails_helper'

RSpec.describe Blog, type: :model do


  describe '#initialize' do
    context "valid params" do
      it 'returns a valid blog with languages' do
        blog = build(:blog)
        expect(blog.valid?).to eq(true)
      end

      it 'returns a valid blog without languages' do
        blog = build(:blog, languages: [])
        expect(blog.valid?).to eq(true)
      end
    end

    context "invalid params" do
      it 'returns a invalid blog without title' do
        blog = build(:blog, title: "")
        blog.valid?
        expect(blog.errors.messages).to eq( {title: ["can't be blank"]})
      end

      it 'returns a invalid blog without url' do
        blog = build(:blog, url: "")
        blog.valid?
        expect(blog.errors.messages).to eq({ url: ["can't be blank"]})
      end
    end
  end
end