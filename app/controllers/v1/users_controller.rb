# frozen_string_literal: true

class V1::UsersController < V1::BaseController
  before_action :find_users, only: :index
  before_action :find_user, only: %i[update show destroy]

  def index
    ElasticAPM.report_message('This should probably never happen?!')
    render json: V1::UserSerializer.new(@users)
  end

  def show
    @user = User.find(params[:id])
    render json: V1::UserSerializer.new(@user)
  end

  def create
    user = User.create!(phone: "380#{rand(100_000_000..999_999_999)}")
    render json: V1::UserSerializer.new(user)
  end

  def update
    @user.update!(user_params)
    render json: V1::UserSerializer.new(@user)
  end

  def destroy
    @user.delete!
    render json: V1::UserSerializer.new(@user)
  end

  private

  def find_users
    @users = if params[:phones].present?
      User.where(phone: params[:phones])
    elsif params[:ids].present?
      User.where(id: params[:ids])
    else
      User.all
    end

    @users = @users.order(:id).page(params[:page]).per(params[:per_page]).without_count
  end

  def user_params
    params.permit(:first_name, :last_name)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
