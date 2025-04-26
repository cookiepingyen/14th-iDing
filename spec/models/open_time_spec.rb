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
require 'rails_helper'

RSpec.describe OpenTime, type: :model do
  subject { build(:open_time) }

  context 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'end_time 必須大於 start_time' do
      open_time = build(:open_time)
      open_time.end_time = open_time.start_time.advance(hours: -1)
      expect(open_time).not_to be_valid
    end

    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
  end

  context 'Associations' do
    it { should belong_to(:restaurant) }
  end
end
