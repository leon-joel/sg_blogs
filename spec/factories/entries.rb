FactoryGirl.define do
  factory :entry do
    association :blog   # blog ファクトリーを使って親要素となるblogが生成される
    title "First Entry"
    body "Hello Blog!"
  end
end
