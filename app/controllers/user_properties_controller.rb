class UserPropertiesController < ApplicationController
  before_action :authenticate_user

  def index
    authenticate_user
    props = @current_user.properties
    properties = @current_user.properties
    user_props = @current_user.user_properties
    properties = properties.map do |property|
      photo_urls = property.photos.map { |photo| rails_blob_url(photo) }
      prop_data = user_props.find_by(property:).slice("active", "favorite", "contacted")

      property_attributes = property.attributes.except("created_at", "updated_at", "id")

      property_data = property_attributes.merge(photos: photo_urls, property: prop_data)

      property_data
    end

    render json: properties
  end

  def show
    authenticate_user
    id = params[:id]

    p @current_user.properties
    property = @current_user.properties.find_by(id:)
    if property
      @photo_urls = property.photos.map { |photo| rails_blob_url(photo) }
      result = property.attributes.merge(photos: @photo_urls)
      render json: result
    else
      render json: { message: "Property not found" }, status: :not_found
    end
  end

  private

  def authenticate_user
    auth_token = request.headers["Authorization"]
    @current_user = User.find_by(auth_token:)
    puts "-------------------------"
    p @current_user
    return if @current_user

    render json: { error: "No autorizado." }, status: :unauthorized
  end
end
