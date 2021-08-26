class SpotsController < ApplicationController

#   def index
# # firstaddress = Geocoder.search(params[:first_address])
#     if params[:first_address].present? && params[:second_address].present?

#       @first_address = params[:first_address]
#       @first_address = Geocoder.search(params[:first_address])
#       @first_address_coordinates = @first_address.first.coordinates

#       @second_address = params[:second_address]
#       @second_address = Geocoder.search(params[:second_address])
#       @second_address_coordinates = @second_address.first.coordinates


#       @centre_point = Geocoder::Calculations.geographic_center([@first_address_coordinates, @second_address_coordinates])
#       @centre_point_lat = @centre_point.first
#       @centre_point_lon = @centre_point.second

#       @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])

#       @spots = @client.spots(@centre_point_lat, @centre_point_lon, :types => 'restaurant')

#       @markers = @spots.map do |spot|
#         {
#           lat: spot.lat,
#           lng: spot.lng
#         }
#       end
#     end
#   end

  def index
    first_address
    second_address
    center_point
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    @spots = @client.spots(@centre_point_lat, @centre_point_lon, :types => 'restaurant')
    marker(@spots)
  end

  def first_address
    @first_address = params[:first_address]
    @first_address = Geocoder.search(params[:first_address])
    @first_address_coordinates = @first_address.first.coordinates
  end

  def second_address
    @second_address = params[:second_address]
    @second_address = Geocoder.search(params[:second_address])
    @second_address_coordinates = @second_address.first.coordinates
  end

  def center_point
    @centre_point = Geocoder::Calculations.geographic_center([@first_address_coordinates, @second_address_coordinates])
    @centre_point_lat = @centre_point.first
    @centre_point_lon = @centre_point.second
  end

  def marker(spots)
    @markers = spots.map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng
      }
    end
  end

def show
  center_point
end

end
