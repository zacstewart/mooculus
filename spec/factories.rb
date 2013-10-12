FactoryGirl.define do
  factory :user do
    name "Ryan"
    email "sample@example.com"
    password "password"
  end

  factory :exercise do
    sequence(:title) {|n| "Sample #{n}"}
    sequence(:description) {|n| "This is a description of Sample #{n}."}
    sequence(:page) {|n| "sample_#{n}.html"}
    sequence(:position)
  end

  factory :problem do
    weight 10
    sequence(:name) { |n| "Problem #{n}" }
  end

  factory :score do
    sequence(:time_taken) {|n| 10+n}
    sequence(:attempt_number) {|n| 10+n}
    sequence(:complete) {|n| 10+n}
    sequence(:count_hints) {|n| 10+n}
    sequence(:attempt_content) {|n| 10+n}
    sequence(:seed) {|n| 10+n}
  end

  factory :competency do
    uncertainty 0.25
    min_estimate 0.5
    max_estimate 0.5
    estimate 0.5
  end

end

