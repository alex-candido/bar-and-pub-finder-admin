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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  username               :string
#  info                   :jsonb
#  preferences            :jsonb
#  role                   :integer          default("registered"), not null
#  status                 :integer          default("active"), not null
#
require "faker"

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    username { Faker::Internet.username }
    password { "123456" }
    password_confirmation { "123456" }
  end
end
