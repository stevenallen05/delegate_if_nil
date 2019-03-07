FactoryBot.define do
    factory :parent do        
        attribute_one { "string" }
        attribute_two { "string" }
        grandparent { build :grandparent }

        trait :falls_back do
            attribute_one { nil }
            attribute_two { nil }
        end
    end
end