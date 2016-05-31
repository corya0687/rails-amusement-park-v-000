class AttractionsController < ApplicationController
  before_filter :set_attraction, only: [:show, :update, :edit]


  def index
    @attractions = Attraction.all
  end

  def show

  end

  def create
    @attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  def new
    @attraction = Attraction.new
  end

  def edit

  end

  def update
    if current_user.admin
      @attraction.update(attraction_params)
      redirect_to attraction_path(@attraction)
    else
      ride= @attraction.rides.build(attraction_id: @attraction.id, user_id: current_user.id)
      if !ride.unqualified?
        ride.take_ride
        flash[:notice]= "Thanks for riding the Ferris Wheel!"
        redirect_to user_path(current_user)
      elsif ride.no_tickets_short?
        flash[:notice]= ride.no_tickets_short?
        redirect_to user_path(current_user)

      elsif ride.enough_tickets?
        flash[:notice]= ride.enough_tickets?
        redirect_to user_path(current_user)

      elsif ride.tall_enough?
        flash[:notice]= ride.tall_enough?
        redirect_to user_path(current_user)

      end

    end
  end



  private

  def set_attraction
    @attraction = Attraction.find(params[:id])
  end

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end
end
