class Flight
  include Mongoid::Document
  field :price, type: Float
  field :way_duration, type: Integer
  attr_accessible :price, :hops_attributes

  embeds_many :hops#, cascade_callbacks: true
  accepts_nested_attributes_for :hops

  validates_presence_of :price
  validates_numericality_of :price, greater_than_or_equal_to: 0

  validates_associated :hops

  before_create :set_way_duration

  def set_way_duration
    self.way_duration = (hops.last.arrival_time - hops.first.date).to_i if hops.any?
  end
end
