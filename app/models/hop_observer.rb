class HopObserver < Mongoid::Observer
  def after_create(hop)
    set_flight_way_duration hop
  end

  def after_update(hop)
    set_flight_way_duration hop
  end

  def after_destroy(hop)
    set_flight_way_duration hop
  end

  private

    def set_flight_way_duration(hop)
      flight = hop.flight
      flight.set_way_duration
      flight.save!
    end
end
