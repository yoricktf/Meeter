class SpotsController < ApplicationController

  def index
    first_address
    second_address
    center_point
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    marked_results
    marker(@spots)
    location_markers

    # single_marker(@first_address_coordinates)

  end

  def share
    @first_address = params[:first_address]
    @second_address = params[:second_address]
  end

  def result
    # we cannot use show, we had to call it differently
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    @result = @client.spot(params[:place_id])
    @url = @result.photos[0].fetch_url(800)
    single_marker(@result)
  end

  private

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

  def marked_results
    @spots = @client.spots(@centre_point_lat, @centre_point_lon, :types => params[:spot_type].downcase, :radius => 1000)
    @spots = @spots.take(3)
  end

  def marker(spots)
    @markers = spots.map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng,
        image_url: helpers.asset_url("#{params[:spot_type]}.png")
      }

    end
  end

  def single_marker(result)
    @marker = [
      {
        lat: result.lat,
        lng: result.lng,
        image_url: helpers.asset_url("#{params[:spot_type]}.png")
      }
    ]
  end

  def location_markers
    @markers << {
                  lat: @first_address_coordinates[0],
                  lng: @first_address_coordinates[1],
                  image_url: helpers.asset_url("location.png")
                }
    @markers << {
                  lat: @second_address_coordinates[0],
                  lng: @second_address_coordinates[1],
                  image_url: helpers.asset_url("location.png")
                }
  end
end
