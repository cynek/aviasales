# #encoding: utf-8
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

require 'spec_helper'

describe Flight do
  def diff_last_arrival_time_and_first_date
    (subject.hops.last.arrival_time - subject.hops.first.date).to_i
  end
  before do
    @correct_hops_attrs = []
    @correct_hops_attrs[0] =  {
        :latstart => "11.111111",
        :lonstart => "111.111111",
        :latend => "22.222222",
        :lonend => "222.222222",
        :date => Time.now,
        :duration => 3600 }
    @correct_hops_attrs[1] = {
        :latstart => "22.222222",
        :lonstart => "222.222222",
        :latend => "33.333333",
        :lonend => "333.333333",
        :date => Time.now + @correct_hops_attrs[0][:duration],
        :duration => 3600 }
    @correct_hops_attrs[2] = {
        :latstart => "33.333333",
        :lonstart => "333.333333",
        :latend => "44.444444",
        :lonend => "444.444444",
        :date => Time.now + @correct_hops_attrs[1][:duration],
        :duration => 3600 }
    @correct_attr = {
      :price => 1.00,
      :hops_attributes => @correct_hops_attrs
    }
  end
  subject { Flight.new(@correct_attr) }

  it { subject.save! }

  describe "#hops" do
    it { should respond_to(:hops) }
  end
  describe "#price" do
    it { subject.price = nil; subject.should be_invalid }
    it { subject.price = 'a'; subject.should be_invalid }
    it { subject.price = -1.00; subject.should be_invalid }
  end

  describe "#way_duration" do
    it { subject.save!; subject.way_duration.should be == diff_last_arrival_time_and_first_date }
  end

  describe "#set_way_duration" do
    it "должно присваивать way_duration разницу между временем последнего приземления и началом полета" do
      subject.should_receive(:way_duration=).with(diff_last_arrival_time_and_first_date)
      subject.send(:set_way_duration)
    end
  end

end
