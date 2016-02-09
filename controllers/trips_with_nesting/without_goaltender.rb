class TripsController < ApplicationController
  def create
    modified_params = trip_params.dup
    modified_params = parse_start_date(modified_params)
    modified_params = parse_end_date(modified_params)
    modified_params = parse_destinations_dates(modified_params)

    @trip = Trip.new(modified_params)

    if @trip.save
      redirect_to basic_example_trip_path(@trip)
    else
      render 'new'
    end
  end

  private

    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date, destinations_attributes: [:city, :state, :arrival_date, :departure_date])
    end

    def parse_destinations_dates(modified_params)
      modified_params[:destinations_attributes].each do |destination_hash|
        destination_hash[:arrival_date] = parse_date(destination_hash[:arrival_date]) if destination_hash[:arrival_date]
        destination_hash[:departure_date] = parse_date(destination_hash[:departure_date]) if destination_hash[:departure_date]
      end
      return modified_params
    end

    def parse_end_date(modified_params)
      return if modified_params[:end_date].nil?
      modified_params[:end_date] = parse_date(modified_params[:end_date])
      return modified_params
    end

    def parse_start_date(modified_params)
      return if modified_params[:start_date].nil?
      modified_params[:start_date] = parse_date(modified_params[:start_date])
      return modified_params
    end

    def parse_date(date_string)
      DateTime.strptime(date_string, '%m/%d/%Y')
    end
end
