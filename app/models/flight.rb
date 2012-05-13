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

class Flight < ActiveRecord::Base
  attr_accessible :price, :hops_attributes
  has_many :hops
  accepts_nested_attributes_for :hops
  validates :price,
    :presence => true,
    :numericality => {:greater_than_or_equal_to => 0}
  validates_associated :hops
  before_create :set_way_duration

  def set_way_duration
    self.way_duration = (hops.last.arrival_time - hops.first.date).to_i if hops.any?
  end
end
