class TripsController < ApplicationController
  def create
    @trip = Trip.new(trip_params)
    start_date = Date.strptime(trip_params[:start_date], '%m/%d/%Y')
    end_date = Date.strptime(trip_params[:end_date], '%m/%d/%Y')
    @trip.start_date = start_date
    @trip.end_date = end_date

    if @trip.save
      redirect_to basic_example_trips_no_goaltender_path(@trip)
    else
      render 'trips/new'
    end
  end

  private

    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date)
    end
end
