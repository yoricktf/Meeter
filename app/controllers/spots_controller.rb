class SpotsController < ApplicationController

  def index
    first_address
    second_address
    center_point
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    marked_results
    marker(@spots)
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
    @spots = @client.spots(@centre_point_lat, @centre_point_lon, :types => "#{params[:spot_type]}", :radius => 1000)
    @spots = @spots.take(3)
  end

  def marker(spots)
    @markers = spots.map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng,
        image_url: helpers.asset_url('/Users/yorick/code/yoricktf/Meeter/app/assets/images/cafe.png')
      }
    end
  end

  def single_marker(result)
    @marker = [
      {
        lat: result.lat,
        lng: result.lng
      }
    ]
  end
end
