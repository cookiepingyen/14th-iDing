# frozen_string_literal: true

# == Schema Information
#
# Table name: restaurants
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  url              :string           not null
#  tel              :string           not null
#  address          :string           not null
#  description      :text
#  ubn              :string
#  image            :string
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  reserve_interval :integer          default(15)
#  mealtime         :integer          default(60)
#  bookday_advance  :integer          default(14)
#  deleted_at       :datetime
#  menus            :json
#  slug             :string
#
FactoryBot.define do
  factory :restaurant do
    name { FFaker::Lorem.characters.first(20) }
    sequence(:url) { |n| "test-restaurant-#{n}" }
    tel { FFaker::PhoneNumberTW.mobile_phone_number }
    address { FFaker::Lorem.characters.first(20) }
    description { FFaker::Lorem.paragraph }
    ubn { rand(10000000..99999999).to_s }
    user { association(:user, :confirmed) }

    trait :with_image do
      image { File.open(Rails.root.join('spec/fixtures/image.jpg')) }
    end

    trait :with_menus do
      menus { [File.open(Rails.root.join('spec/fixtures/menu.jpg'))] }
    end

    trait :with_mealtime do
      mealtime { 60 }
    end

    trait :with_bookday_advance do
      bookday_advance { 14 }
    end

    trait :with_reserve_interval do
      reserve_interval { 15 }
    end

    trait :with_holidays do
      after(:build) do |restaurant|
        holiday = build(:holiday, restaurant: restaurant)
      end
    end

    trait :with_open_times do
      after(:build) do |restaurant|
        open_time = build(:open_time, restaurant: restaurant)
      end
    end

    factory :can_reserve_restaurant, traits: [:with_mealtime, :with_bookday_advance, :with_reserve_interval, :with_holidays, :with_open_times]
  end
end
