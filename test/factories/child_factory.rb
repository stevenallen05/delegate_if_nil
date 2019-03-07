FactoryBot.define do
    factory :child do
        attribute_one { "string" }
        attribute_two { "string" }
        parent { build :parent }

        trait :falls_back do
            attribute_one { nil }
            attribute_two { nil }
        end
    end
end