#encoding: utf-8
require 'spec_helper'

describe FlightsController do
  before do
    @correct_attributes = {
      :price => 1.00,
      :hops_attributes => [{
        :start => [11.111111,111.111111],
        :end => [22.111111,122.222222],
        :date => Time.now,
        :duration => 1.hour
      },{
        :start => [22.222222,122.222222],
        :end => [33.333333,133.333333],
        :date => Time.now,
        :duration => 2.hours
      }]
    }
  end
  describe "POST :create" do
    subject { post :create, :flight => @correct_attributes, :format => :json }
    it { subject; assigns(:flight).should be_an_instance_of(Flight) }
    it { expect {subject}.to change(Flight, :count).by(1) }
    it { subject; response.status.should be == 201 }
    describe "с некорректными атрибутами" do
      subject { post :create, :flight => {}, :format => :json }
      it { subject; response.status.should be == 422 }
    end
  end
  describe "GET :search" do
    before do
      @flights = [
        Flight.create!(@correct_attributes),
        Flight.create!(@correct_attributes.merge(:price => 2.00))
      ]
      @search_attributes = {
        :start => @correct_attributes[:hops_attributes][0][:start],
        :end => @correct_attributes[:hops_attributes][1][:end],
        :max_price => 1.00,
        :from_date => Time.now,
        :to_date => Time.now + 1.day,
        :max_transfers_count => 1,
        :max_way_duration => 1.hour
      }
    end
    subject { get :search, @search_attributes }
    it { subject; assigns(:found_ways).each {|found_way| found_way.should be_an_instance_of(WaySearch) } }
    it { subject; assigns(:found_ways).each {|found_way| found_way.flights.should be == [@flight] } }
  end
end
