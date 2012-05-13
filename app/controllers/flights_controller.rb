class FlightsController < ApplicationController
  respond_to :json

  def create
    @flight = Flight.create(params[:flight])
    respond_with @flight
  end
end
