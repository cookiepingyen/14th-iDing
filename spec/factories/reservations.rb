# == Schema Information
#
# Table name: reservations
#
#  id            :bigint           not null, primary key
#  date          :date             not null
#  time          :time             not null
#  adults        :integer          not null
#  kids          :integer          not null
#  purpose       :string
#  note          :text
#  serial        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint           not null
#  name          :string           not null
#  email         :string
#  gender        :integer
#  tel           :string           not null
#  deleted_at    :datetime
#  table_id      :bigint
#  state         :string           default("reserved")
#  slug          :string
#
FactoryBot.define do
  factory :reservation do
    date { Date.current }
    time { Time.current.change(hour: 12) }
    name { Faker::Name.name }
    tel { FFaker::PhoneNumberTW.mobile_phone_number }
    adults { rand(1..4) }
    kids { rand(0..2) }
    purpose { ['慶生', '約會', '商務', '聚餐'].sample }
    note { FFaker::Lorem.sentence }
    state { 'reserved' }
    email { FFaker::Internet.email }
    gender { rand(0..2) }

    restaurant { create(:can_reserve_restaurant) }
    table { create(:table, restaurant: restaurant, seat_num: adults + kids + 2) }

    trait :keeped do
      state { 'keeped' }
    end

    trait :used do
      state { 'used' }
    end

    trait :completed do
      state { 'completed' }
    end

    trait :cancelled do
      state { 'cancelled' }
    end
  end
end
