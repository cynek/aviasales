class Hop
  include Mongoid::Document
  field :start, type: Array
  field :end, type: Array#, spacial: true
  field :date, type: Time
  field :duration, type: Integer, default: 0
  embedded_in :flight
  attr_accessible :date, :duration, :start, :end

  validates :start,
    :presence => true,
    :spacial => { :not_equal => :end }
  validates :end,
    :presence => true,
    :spacial => true

  def arrival_time
    self.date + self.duration
  end
end
