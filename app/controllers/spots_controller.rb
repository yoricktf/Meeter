class SpotsController < ApplicationController

  def index
# firstaddress = Geocoder.search(params[:first_address])
    @first_address = params[:first_address]
    @second_address = params[:second_address]

    @first_address = Geocoder.search(params[:first_address])
    @first_address_coordinates = @first_address.first.coordinates

    @second_address = Geocoder.search(params[:second_address])
    @second_address_coordinates = @second_address.first.coordinates

    @centre_point = Geocoder::Calculations.geographic_center([@first_address_coordinates, @second_address_coordinates])

  end
end
