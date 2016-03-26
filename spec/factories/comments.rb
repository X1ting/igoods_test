FactoryGirl.define do
  factory :comment do
    user nil
    body "MyText"
    article nil
  end
end
