class SpotsController < ApplicationController

  def index
# firstaddress = Geocoder.search(params[:first_address])
    if params[:first_address].present? && params[:second_address].present?
      @first_address = params[:first_address]
      @second_address = params[:second_address]
      @spot_type = params[:spot_type]

      @first_address = Geocoder.search(params[:first_address])
      @first_address_coordinates = @first_address.first.coordinates

      @second_address = Geocoder.search(params[:second_address])
      @second_address_coordinates = @second_address.first.coordinates

      @spot_type = Geocoder.search(params[:spot_type])

      @centre_point = Geocoder::Calculations.geographic_center([@first_address_coordinates, @second_address_coordinates])

      @centre_point_lat = @centre_point.first
      @centre_point_lon = @centre_point.second

      @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])

      @spots = @client.spots(@centre_point_lat, @centre_point_lon, :types => `#{params[:spot_type]}`)
      @spots = @spots.take(20)

      @markers = @spots.map do |spot|
        {
          lat: spot.lat,
          lng: spot.lng
        }
      end
    end
  end
end
