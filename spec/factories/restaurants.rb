# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant do
    name { FFaker::Lorem.characters.first(20) }
    sequence(:url) { |n| "test-restaurant-#{n}" }
    tel { FFaker::PhoneNumberTW.mobile_phone_number }
    address { FFaker::Lorem.characters.first(20) }
    description { FFaker::Lorem.paragraph }
    ubn { rand(10000000..99999999).to_s }
    association :user

    trait :with_image do
      after(:build) do |restaurant|
        restaurant.image.attach(io: File.open('spec/fixtures/image.jpg'), filename: 'image.jpg')
      end
    end

    trait :with_menus do
      after(:build) do |restaurant|
        restaurant.menus.attach(io: File.open('spec/fixtures/menu.jpg'), filename: 'menu.jpg')
      end
    end
  end
end
