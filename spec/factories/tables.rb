# == Schema Information
#
# Table name: tables
#
#  id            :bigint           not null, primary key
#  name          :string
#  seat_num      :integer
#  status        :string
#  category      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint           not null
#  site_x        :integer          default(1)
#  site_y        :integer          default(1)
#
FactoryBot.define do
  factory :table do
    sequence(:name) { |n| "A#{n}" }
    seat_num { (2..8).to_a.sample }
    category { Table.categories.keys.sample }
    association :restaurant

    trait :occupied do
      status { 'occupied' }
    end

    trait :vacant do
      status { 'vacant' }
    end
  end
end
