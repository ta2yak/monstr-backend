FactoryGirl.define do
  factory :post do
    title "HelloWorld"
    body "Hello World"
    is_wip false

    factory :post_with_index1 do
      title "2015/06/14/14days_text"
    end

    factory :post_with_index2 do
      title "2015/06/16/16days_text"
    end

    factory :post_with_wip do
      is_wip true
    end

  end

end
