FactoryBot.define do
    factory :grandparent do
        attribute_one { "string" }
        attribute_two { "string" }

        trait :all_unset do
            attribute_one { nil }
            attribute_two { nil }    
        end
    end
end