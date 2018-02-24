class BookingsController < ApplicationController
  before_action :set_time_from_params, only: [:reserve!, :reserve_for_user]
  before_action :set_current_user, only: [:show_booking_history, :reserve_car, :reserve!, :reserve_now]
  before_action :set_car_from_params, only: [:check_out_history_car, :reserve_car, :reserve!, :reserve_now, :reserve_for_user, :delete_booking]

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find params[:id]
    respond_to do |format|
      if @booking.update(:bookable_id=>params[:booking][:bookable_id],:booker_id=>params[:booking][:booker_id],:time_start=>params[:booking][:time_start],:time_end=>params[:booking][:time_end])
        format.html { redirect_to bookings_path, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @bookings=Booking.all
  end

  def check_out_history_car
    @books1 = @car.bookings
  end

  def checkout_car
    booking = Booking.where( :booker_id => current_user.id)
    car = Car.find(booking.first.bookable_id)
    car.status = "Checked out"
    car.save!
    flash[:notice] = "Car successfully checked out!"
    redirect_to root_path
  end

  def show_booking_history
    @book1 = Booking.with_deleted.where(:booker_id => @user.id).where.not(:deleted_at => nil)
  end

  def reserve_car
  end

  def reserve!
    car_is_reserved = Booking.find_by_bookable_id(@car.id)
    user_has_booked_a_car = Booking.where(:booker_id => @user.id).last
    if user_has_booked_a_car
      flash[:notice] = "You have already booked a car!"
      redirect_to(root_path)
    elsif car_is_reserved && @time_start < car_is_reserved.time_end
      flash[:notice] = "Please try booking the car for a different time!"
      redirect_to(root_path)
    elsif car_is_reserved.nil? || @time_start > car_is_reserved.time_end
      book_car(@car, @user, @time_start, @time_end, "Reserved")
    end
  end

  def reserve_now
    @time_start = Time.now.to_datetime
    @time_end = (@time_start + params[:time_end].to_i.hours).to_datetime
    car_is_reserved = Booking.find_by_bookable_id(@car.id)
    user_has_booked_a_car = Booking.find_by_booker_id(@user.id)
    if user_has_booked_a_car
      flash[:notice] = "You have already booked a car!"
      redirect_to(root_path)
    elsif car_is_reserved
      flash[:notice] = "Please try booking the car for a different time!"
      redirect_to(root_path)
    else
      if user_has_booked_a_car.nil?
        book_car(@car, @user, @time_start, @time_end, "Reserved")
      end
    end
  end

  def delete_booking
    if current_user.admin? or current_user.super_admin?
      user = Booking.find_by_bookable_id(@car).booker_id
    else
      user = current_user
    end
    user_to_be_deleted = User.find(user)
    unless Booking.where(:bookable_id => @car).count > 1
      @car.update_attribute :status, "Available"
      if @car.register_email and !@car.user.nil?
        mailer = User.find_by_email(@car.user)
        ExampleMailer.sample_email(mailer).deliver
        @car.user = nil
        @car.save!
      end
    end
    delete_reservation(@car, user_to_be_deleted)
    respond_to do |format|
      flash[:notice] = "Reservation has been cancelled!"
      format.html { redirect_to(root_path) }
      format.js
    end
  end

  def delete_reservation(car_to_be_deleted, user_to_be_deleted)
    Booking.where(:bookable_id => car_to_be_deleted.id , :booker_id => user_to_be_deleted).last.destroy
  end

  def reserve_car_for_user
    @users = User.all
  end

  def reserve_for_user
    @useremail = params[:selected_user]
    @user = User.find_by_email(@useremail)
    book_car(@car, @user, @time_start, @time_end, "Reserved")
  end

  def book_car(car, user, time_start, time_end, status)
    begin
      user.book! car, time_start: time_start, time_end: time_end
      respond_to do |format|
        car.update_attribute :status, status
        flash[:notice] = "Car has been successfully reserved!"
        format.html { redirect_to(root_path) }
        format.js
      end
    rescue ActsAsBookable::AvailabilityError
      flash[:notice] = "Please try booking the car for a different time!"
      redirect_to(root_path)
    end
  end

  private
    def set_time_from_params
      if params[:booking][:time_start] == ""
        flash.now[:notice] = "Date cannot be blank!"
        redirect_to(reserve_car_for_user_path)
      else
        @time_start = params[:booking][:time_start].to_datetime
        @time_end = (@time_start + params[:time_end].to_i.hours).to_datetime
      end
    end

    def set_current_user
      @user = current_user
    end

    def set_car_from_params
      @car = Car.find(params[:id])
    end
end
