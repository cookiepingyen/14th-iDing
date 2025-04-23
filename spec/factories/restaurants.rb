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
