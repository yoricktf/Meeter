class SpotsController < ApplicationController

  def index
# firstaddress = Geocoder.search(params[:first_address])
    if params[:first_address].present? && params[:second_address].present?
      @first_address = params[:first_address]
      @second_address = params[:second_address]

      @first_address = Geocoder.search(params[:first_address])
      @first_address_coordinates = @first_address.first.coordinates

      @second_address = Geocoder.search(params[:second_address])
      @second_address_coordinates = @second_address.first.coordinates

      @centre_point = Geocoder::Calculations.geographic_center([@first_address_coordinates, @second_address_coordinates])

      @centre_point_lat = @centre_point.first
      @centre_point_lon = @centre_point.second

      @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])

      @spots = @client.spots(@centre_point_lat, @centre_point_lon, :types => 'restaurant')
      # @spot_type.first(params[:spot_type])

      # @spots = [{Geocoder.coordinates("25 Main St, Cooperstown, NY"),
      # Geocoder.coordinates("25 Main St, Cooperstown, NY")}]


      @markers = @spots.map do |spot|
        {
          lat: spot.lat,
          lng: spot.lng
        }
      end
    end
  end

  def show
    @spot = Spot.find(params[:first_address, :second_address])
  end

end
