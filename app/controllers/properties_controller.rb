class PropertiesController < ApplicationController
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
    if new_property.save
      render json: new_property, status: :created
    else
      render json: new_property.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    id = params[:id]
    property = Property.find_by(id:)
    if property.nil?
      render json: { message: "Company not found" }, status: :not_found
    elsif property.update(property_params)
      render json: property
    else
      render json: property.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    id = params[:id]
    property = Property.find_by(id:)
    if property.nil?
      render json: { message: "Company not found" }, status: :not_found
    else
      property.destroy
      render json: property, status: :no_content
    end
  end

  private

  def property_params
    params.require(:property).permit(:operation, :address, :price, :maintenance, :pets, :bedrooms,
                                     :bathrooms, :area, :description, photos: [])
  end
end
