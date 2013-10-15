# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :to_do do
    title "MyString"
    notes "MyText"
    created_by ""
    completed_by 1
    due_date "2013-10-15 17:39:20"
    assigned_person 1
    todo_category_id 1
  end
end
