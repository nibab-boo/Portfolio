FactoryBot.define do
  factory :project do
    name { "Title"  }
    position { "Position" }
    languages { ["ruby", "html5"] }
    fonts { [] }
    colors { [] }
    experience { "Experience is long." }
  end
end
