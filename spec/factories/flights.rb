# == Schema Information
#
# Table name: flights
#
#  id           :integer         not null, primary key
#  price        :decimal(12, 2)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  hops_count   :integer         default(0), not null
#  way_duration :integer         default(0), not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flight do
    price "9.99"
  end
end
