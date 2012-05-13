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

class Hop < ActiveRecord::Base
  belongs_to :flight, :counter_cache => true
  attr_accessible :date, :duration, :latend, :latstart, :lonend, :lonstart

  belongs_to :prev_hop, :class_name => :Hop
  after_initialize :set_prev_hop, :if => :new_record?
  validates_associated :prev_hop
  #delegate :arrival_time, :to => :prev_hop, :prefix => true, :allow_nil => true

  def arrival_time
    self.date + self.duration
  end

  private

    def set_prev_hop
      if flight
        self.prev_hop = flight.hops.last
      end
    end
end
