# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe do
    title "MyString"
    content "MyText"
    user_id 1
    appetizer false
    vegetarian false
    Chicken false
    Meat false
    Dessert false
  end
end
