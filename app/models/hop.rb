class Hop
  include Mongoid::Document
  field :start, type: Array
  field :end, type: Array, spacial: true
  field :date, type: Time
  field :duration, type: Integer, default: 0
  embedded_in :flight, :counter_cache => true
  recursively_embeds_many
  attr_accessible :date, :duration, :latend, :latstart, :lonend, :lonstart

  after_initialize :set_parent_hop, :if => :new_record?
  validates_associated :parent_hop

  def arrival_time
    self.date + self.duration
  end

  private

    def set_parent_hop
      self.parent_hop = flight.hops.last if flight
    end
end
