# == Schema Information
#
# Table name: holidays
#
#  id            :bigint           not null, primary key
#  dayoff        :string
#  restaurant_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :holiday do
    dayoff { %w[Mon Tue Wed Thu Fri Sat Sun].sample }

    restaurant { association(:restaurant) }
  end
end
