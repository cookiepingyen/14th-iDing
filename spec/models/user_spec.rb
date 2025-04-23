# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string           default("user")
#
:string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject { build(:user) }
    it '具有有效的factory' do
      expect(subject).to be_valid
    end
  end

  context 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  context 'Associations' do
    it { should have_many(:restaurants) }
  end
end
