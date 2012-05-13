# == Schema Information
#
# Table name: hops
#
#  id          :integer         not null, primary key
#  latstart    :decimal(8, 6)   not null
#  lonstart    :decimal(9, 6)   not null
#  latend      :decimal(8, 6)   not null
#  lonend      :decimal(9, 6)   not null
#  date        :datetime        not null
#  duration    :integer         not null
#  flight_id   :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  prev_hop_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hop do
    latstart "11.111111"
    lonstart "111.111111"
    latend "11.111111"
    lonend "111.111111"
    date "2012-05-08 23:50:07"
    duration 3600
    flight nil
  end
end
