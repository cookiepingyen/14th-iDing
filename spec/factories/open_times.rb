# == Schema Information
#
# Table name: open_times
#
#  id            :bigint           not null, primary key
#  start_time    :time
#  end_time      :time
#  restaurant_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :open_time do
    start_time { Time.current }
    end_time { Time.current + (2..6).to_a.sample.hours }

    restaurant { association(:restaurant) }
  end
end
