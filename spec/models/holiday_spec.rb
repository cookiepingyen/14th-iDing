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
:string
#
require 'rails_helper'

RSpec.describe Holiday, type: :model do
  subject { build(:holiday) }

  context 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'dayoff 不能為空' do
      article = build(:holiday, dayoff: nil)
      expect(article).not_to be_valid

      article = build(:holiday, dayoff: '')
      expect(article).not_to be_valid
    end

    it '同一個餐廳下不能有重複的 公休日' do
      holiday = create(:holiday)
      duplicate_holiday = build(:holiday, dayoff: holiday.dayoff, restaurant: holiday.restaurant)

      expect(duplicate_holiday).not_to be_valid
    end

    it 'dayoff 必須是 Mon, Tue, Wed, Thu, Fri, Sat, Sun 其中之一' do
      %w(Mon Tue Wed Thu Fri Sat Sun).each do |dayoff|
        holiday = build(:holiday, dayoff: dayoff)
        expect(holiday).to be_valid
      end
    end

    it 'dayoff 不能是其他字串' do
      %w(Monday Test Three Week).each do |dayoff|
        holiday = build(:holiday, dayoff: dayoff)
        expect(holiday).not_to be_valid
      end
    end
  end

  context 'Associations' do
    it { should belong_to(:restaurant) }
  end
end
