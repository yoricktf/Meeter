class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  #meta tag setup
  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
