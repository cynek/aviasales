#encoding: utf-8
require 'spec_helper'

describe HopObserver do
  before do
    duration = 3600
    @flight = mock_model(Flight, set_way_duration: duration, save!: true)

    @hop = mock_model Hop,
                      flight: @flight,
                      date: Time.current.utc + 2.hours,
                      duration: duration
  end
  subject { HopObserver.instance }

  describe "#after_create" do
    it { @flight.should_receive(:set_way_duration); @flight.should_receive(:save!); subject.after_create @hop }
  end

  describe "#after_update" do
    it { @flight.should_receive(:set_way_duration); @flight.should_receive(:save!); subject.after_update @hop }
  end

  describe "#after_destroy" do
    it { @flight.should_receive(:set_way_duration); @flight.should_receive(:save!); subject.after_destroy @hop }
  end
end
