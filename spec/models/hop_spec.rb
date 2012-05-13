#encoding: utf-8
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

require 'spec_helper'

describe Hop do
  before do
    @flight = FactoryGirl.create(:flight)
    @correct_attr = {
      :latstart => 11.111111,
      :lonstart => 111.111111,
      :latend => 22.222222,
      :lonend => 222.222222,
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

  describe "#prev_hop" do
    describe "если указана предыдущая пересадка" do
      before do
        @prev_hop = @flight.hops.create!(@correct_attr.merge(
          :latstart => @correct_attr[:latend],
          :lonstart => @correct_attr[:lonend],
          :latend => @correct_attr[:latstart],
          :lonend => @correct_attr[:lonstart],
          :date => @correct_attr[:date] - 2.hours))
      end
      it { subject.prev_hop.should be == @prev_hop }
    end
    describe "если пересадок не было добавлено" do
      it { subject.prev_hop.should be_nil }
    end
  end
end
