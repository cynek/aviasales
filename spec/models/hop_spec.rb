#encoding: utf-8
require 'spec_helper'

describe Hop do
  before do
    @flight = FactoryGirl.create(:flight)
    @correct_attr = {
      :start => [11.111111,111.111111],
      :end => [22.222222,122.222222],
      :date => Time.now,
      :duration => 3600
    }
  end
  subject { @flight.hops.build @correct_attr }

  it { subject.save!}
  it { subject.flight.should be == @flight }

  describe "#arrival_time" do
    it { subject.arrival_time.should be == subject.date + subject.duration}
  end

  shared_examples_for "spacial" do
    it { subject.send(:"#{attr}=", []); subject.should be_invalid }
    it { if respond_to? :not_equal; subject.send(:"#{attr}=", not_equal); subject.should be_invalid; end }
    it { subject.send(:"#{attr}=", [11.111111]); subject.should be_invalid }
    it { subject.send(:"#{attr}=", [11.111111, 180.111111]); subject.should be_invalid }
    it { subject.send(:"#{attr}=", [90.111111, 111.111111]); subject.should be_invalid }
  end
  describe "#start" do
    it_should_behave_like "spacial" do
      let(:attr) { :start }
      let(:not_equal) { @correct_attr[:end] }
    end
  end

  describe "#end" do
    it_should_behave_like 'spacial' do
      let(:attr) { :end }
    end
  end

  #describe "#parent_hop" do
    #describe "если указана предыдущая пересадка" do
      #before do
        #@parent_hop = @flight.hops.create!(@correct_attr.merge(
          #:start => @correct_attr[:end],
          #:end => @correct_attr[:start],
          #:date => @correct_attr[:date] - 2.hours))
      #end
      #it { subject.parent_hop.should be == @parent_hop }
    #end
    #describe "если пересадок не было добавлено" do
      #it { subject.parent_hop.should be_nil }
    #end
  #end
end
