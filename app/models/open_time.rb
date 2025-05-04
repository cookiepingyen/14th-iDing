# frozen_string_literal: true

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
class OpenTime < ApplicationRecord
  belongs_to :restaurant
  validates :start_time, :end_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }
  self.skip_time_zone_conversion_for_attributes = [:start_time, :end_time]
end
