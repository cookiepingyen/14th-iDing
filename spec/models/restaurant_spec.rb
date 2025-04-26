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
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject { build(:restaurant) }

  context 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:tel) }
    it { should validate_presence_of(:address) }
  end

  context "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:reservations).dependent(:destroy) }
    it { should have_many(:open_times).dependent(:destroy) }
    it { should have_many(:tables).dependent(:destroy) }
    it { should have_many(:holidays).dependent(:destroy) }
  end
end
