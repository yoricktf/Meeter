class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def spots

    @spots = [{longitude:'2.3798534', latitude:'48.8648482'}, {longitude:'2.3798834', latitude:'48.8649482'}]

    # @spots = [{Geocoder.coordinates("25 Main St, Cooperstown, NY"),
    # Geocoder.coordinates("25 Main St, Cooperstown, NY")}]


    @markers = @spots.map do |spot|
      {
        lat: spot[:latitude],
        lng: spot[:longitude]
      }
    end

  end

end
