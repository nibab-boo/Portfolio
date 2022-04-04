FactoryBot.define do
  factory :blog do
    title { "Title" }
    url { "www.url.com" }
    languages { '[ "rails", "rspec" ]' }
  end
end
