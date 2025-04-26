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
require 'rails_helper'

RSpec.describe Table, type: :model do
  describe 'validations' do
    subject { build(:table) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:seat_num) }
    it { should validate_numericality_of(:seat_num).is_greater_than(0) }

    context '桌號唯一性驗證' do
      let!(:existing_table) { create(:table, name: 'A1') }

      it '同間餐廳 桌號重複 不會通過驗證' do
        new_table = build(:table, restaurant: existing_table.restaurant, name: 'A1')
        expect(new_table).not_to be_valid
      end

      it '不同餐廳 桌號重複 可以通過驗證' do
        new_table = build(:table, name: 'A1')
        expect(new_table).to be_valid
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:restaurant) }
    it { should have_many(:reservations).dependent(:destroy) }
  end

  describe 'enums' do
    it { should define_enum_for(:category).with_values({ '一般座位': 0, '包廂': 1, '沙發': 2, '高腳桌': 3 }) }
  end

  describe 'AASM states' do
    let(:table) { create(:table) }

    it 'has initial state of vacant' do
      expect(table).to be_vacant
    end

    context 'state transitions' do
      it 'can transition from vacant to occupied' do
        expect(table).to be_vacant
        table.occupied!
        expect(table).to be_occupied
      end

      it 'can transition from occupied to vacant' do
        table.occupied!
        expect(table).to be_occupied
        table.vacant!
        expect(table).to be_vacant
      end
    end
  end

  describe 'defaults' do
    it 'sets default site_x to 1' do
      table = create(:table)
      expect(table.site_x).to eq(1)
    end

    it 'sets default site_y to 1' do
      table = create(:table)
      expect(table.site_y).to eq(1)
    end
  end
end
