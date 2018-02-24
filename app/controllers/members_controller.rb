class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /members
  # GET /members.json
  def index
    @members = User.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = User.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json

  def create
    @member = User.new(member_params)
    if current_user.admin? || current_user.super_admin?
      if params[:UserType] == "1"
        @member.admin = true
      end
      if params[:UserType]== "2"
        @member.super_admin = true
      end
    end
    respond_to do |format|
      if @member.save
        format.html { redirect_to root_path, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    if Booking.where(:booker_id => @member.id).exists?
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'That member has booked a car!' }
        format.json { head :no_content }
      end
    else
      @member.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Member was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def admin_show_page
    @user1 = User.where(admin: true, super_admin: false)
  end

  def admin_watch_user

  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:user).permit(:name,:email,:password,:admin,:super_admin)
    end
end
