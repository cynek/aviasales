#encoding: utf-8
require 'spec_helper'

describe FlightsController do
  before do
    @correct_attributes = {
      :price => 1.00,
      :hops_attributes => [{
        :latstart => 11.111111,
        :lonstart => 111.111111,
        :latend => 11.111111,
        :lonend => 111.111111,
        :date => Time.now,
        :duration => 1
      }]
    }
  end
  describe "POST :create" do
    subject { post :create, :flight => @correct_attributes, :format => :json }
    it { subject; assigns(:flight).should be_an_instance_of(Flight) }
    it { expect {subject}.to change(Flight, :count).by(1) }
    it { subject; response.status.should be == 201 }
    describe "с некорректными данными" do
      subject { post :create, :flight => {}, :format => :json }
      it { subject; response.status.should be == 422 }
    end
  end
end
