class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /cars
  # GET /cars.json

  def index
    @cars = Car.all
    @user_has_booked_a_car = Booking.find_by_booker_id(current_user.id)
    @options_for_search = @cars.attribute_names.select {|i| i.include?("location") || i.include?("model") || i.include?("manufacturer") || i.include?("style") || i.include?("status" )}
    if !params[:search].blank? and !params[:search_by].blank?
      @cars = Car.search(params[:search], params[:search_by]).order("created_at DESC")
    else
      @recipes = Car.all.order("created_at DESC")
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    @car.schedule = IceCube::Schedule.new(Time.now.beginning_of_day, duration: 24.hours)
    @car.schedule.add_recurrence_rule IceCube::Rule.daily
    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    if Booking.where(:bookable_id => @car.id).exists?
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'That car is booked by a user!' }
        format.json { head :no_content }
      end
    else
      @car.destroy
      respond_to do |format|
        format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def request_for_notification
    @car = Car.find(params[:id])
    @user = User.find(params[:id1])
    @car.update_attribute(:user, @user.email)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:license_plate, :manufacturer, :model, :hourly_rental_rate, :style, :location,
                                  :status, :time_start, :time_end, :register_email)
    end
end
