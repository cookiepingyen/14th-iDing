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
require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    subject { build(:reservation) }

    before do
      Reservation.skip_callback(:validation, :before, :valid_total_guests)
    end

    after do
      Reservation.set_callback(:validation, :before, :valid_total_guests)
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:time) }
    it { should validate_presence_of(:adults) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:tel) }
    it { should validate_numericality_of(:adults).is_greater_than(0) }
    it { should validate_presence_of(:kids) }
    it { should validate_numericality_of(:kids).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    before do
      Reservation.skip_callback(:validation, :before, :valid_total_guests)
    end

    after do
      Reservation.set_callback(:validation, :before, :valid_total_guests)
    end

    it { should belong_to(:restaurant) }
    it { should belong_to(:table).optional }
  end

  describe '訂單人數 驗證' do
    let!(:restaurant) { create(:restaurant) }
    let!(:table) { create(:table, restaurant: restaurant, seat_num: 4) }

    it '訂單的人數 必須比 餐廳的桌子容納人數 小' do
      reservation = build(:reservation, restaurant: restaurant, adults: 10, kids: 5, table: table)
      expect(reservation).not_to be_valid
    end

    it '訂單的人數 不可以比 餐廳的桌子容納人數 大' do
      reservation = build(:reservation, restaurant: restaurant, adults: 10, kids: 5, table: table)
      expect(reservation).not_to be_valid
    end
  end

  describe 'state machine' do
    let(:reservation) { create(:reservation) }

    it 'has initial state of reserved' do
      expect(reservation).to be_reserved
    end

    context 'state transitions' do
      it 'can transition from reserved to keeped' do
        expect(reservation.keep!).to be true
        expect(reservation).to be_keeped
      end

      it 'can transition from reserved to used' do
        expect(reservation.use!).to be true
        expect(reservation).to be_used
      end

      it 'can transition from keeped to used' do
        reservation.keep!
        expect(reservation.use!).to be true
        expect(reservation).to be_used
      end

      it 'can transition from used to completed' do
        reservation.use!
        expect(reservation.complete!).to be true
        expect(reservation).to be_completed
      end

      it 'updates table status when transitioning to used' do
        reservation = create(:reservation)
        reservation.use!
        expect(reservation.table).to be_occupied
      end

      it 'updates table status when transitioning to completed' do
        reservation = create(:reservation)
        reservation.use!
        reservation.complete!
        expect(reservation.table).to be_vacant
      end
    end
  end

  describe '.search' do
    let!(:reservation1) { create(:reservation, name: 'John Doe', tel: '1234567890', date: Date.current) }
    let!(:reservation2) { create(:reservation, name: 'Jane Smith', tel: '0987654321', date: Date.tomorrow) }

    it 'searches by date' do
      result = described_class.search(date_eq: Date.current)
      expect(result).to include(reservation1)
      expect(result).not_to include(reservation2)
    end

    it 'searches by name or tel' do
      result = described_class.search(name_or_tel_cont: 'John')
      expect(result).to include(reservation1)
      expect(result).not_to include(reservation2)
    end
  end
end
