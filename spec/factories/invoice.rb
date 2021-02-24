FactoryBot.define do
   factory :invoice do
      status { "cancelled" or "in progress" or "completed" }
      customer
   end
 end
