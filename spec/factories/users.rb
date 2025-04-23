# frozen_string_literal: true

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
FactoryBot.define do
  password = FFaker::Internet.password

  factory :user do
    email { FFaker::Internet.email }
    password { password }
    password_confirmation { password }

    trait :with_name do
      name { FFaker::NameTW.name }
    end

    trait :confirmed do
      confirmed_at { DateTime.current }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end
  end
end
