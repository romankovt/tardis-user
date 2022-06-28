# frozen_string_literal: true

class V1::BaseController < ApplicationController
  extend Memoist

  rescue_from StandardError,                    with: :render_internal_service_error if Rails.env.production?
  rescue_from ActiveRecord::RecordInvalid,      with: :render_record_invalid_response
  rescue_from ActiveRecord::RecordNotDestroyed, with: :render_record_invalid_response
  rescue_from ActiveRecord::RecordNotFound,     with: :render_not_found_response
  rescue_from ActiveRecord::RecordNotUnique,    with: :render_record_not_unique_response
  rescue_from ActiveRecord::ReadOnlyRecord,     with: :render_read_only_record_response

  private

  def render_record_invalid_response
    render json: { message: "record invalid" }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { message: "record not found" }, status: :not_found
  end

  def render_record_not_unique_response
    render json: { message: "record not unique" }, status: :unprocessable_entity
  end

  def render_read_only_record_response
    render json: { message: "record is read onlt" }, status: :unprocessable_entity
  end
end
