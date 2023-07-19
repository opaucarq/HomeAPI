class PropertiesController < ApplicationController
  def index
    @property = Property.first
    @photo_urls = @property.photos.map { |photo| rails_blob_url(photo) }
    result = @property.attributes.merge(photo_urls: @photo_urls)
    render json: result
  end
end
