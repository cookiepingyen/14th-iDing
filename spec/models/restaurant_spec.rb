# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'Validations' do
    subject { build(:restaurant) }
    it '具有有效的factory' do
      expect(subject).to be_valid
    end
  end

  context 'Validations' do
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
