# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |n| "測試餐廳#{n}" }
    sequence(:url) { |n| "test-restaurant-#{n}" }
    tel { "02-#{rand(1000..9999)}-#{rand(1000..9999)}" }
    address { "台北市測試區測試路#{rand(1..100)}號" }
    description { "這是一個測試餐廳描述" }
    ubn { rand(10000000..99999999).to_s }
    association :user

    trait :with_image do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_image.jpg'), 'image/jpeg') }
    end

    trait :with_menus do
      menus { [Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_menu.pdf'), 'application/pdf')] }
    end
  end
end
