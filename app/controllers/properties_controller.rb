class PropertiesController < ApplicationController
  before_action :authenticate_user, except: %i[index show]

  def index
    properties = Property.all.map do |property|
      photo_urls = property.photos.map { |photo| rails_blob_url(photo) }
      property.attributes.merge(photos: photo_urls)
    end

    render json: properties
  end

  def show
    id = params[:id]
    property = Property.find_by(id:)
    if property
      @photo_urls = property.photos.map { |photo| rails_blob_url(photo) }
      result = property.attributes.merge(photos: @photo_urls)
      render json: result
    else
      render json: { message: "Property not found" }, status: :not_found
    end
  end

  def create
    new_property = Property.new(property_params)
    # agregar lógica para el rol

    if new_property.save
      @current_user.user_properties.create(
        property: new_property
      )
      render json: new_property, status: :created
    else
      render json: new_property.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    id = params[:id]
    property = @current_user.properties.find_by(id:)

    if property.nil?
      render json: { message: "Property not found" }, status: :not_found
    elsif property.update(property_params)
      render json: property
    else
      render json: property.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def property_params
    params.require(:property).permit(:operation, :address, :price, :maintenance, :pets, :bedrooms,
                                     :bathrooms, :area, :description, photos: [])
  end

  def authenticate_user
    auth_token = request.headers["Authorization"]
    @current_user = User.find_by(auth_token:)
    puts "//////////////////////////////////////"
    p @current_user
    return if @current_user

    render json: { error: "No autorizado." }, status: :unauthorized
  end
end
