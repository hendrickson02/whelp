class EventReviewsController < ApplicationController
  before_action :set_event_review, only: [:show, :edit, :update, :destroy]

  # GET /event_reviews
  # GET /event_reviews.json
  def index
    @event_reviews = EventReview.all
    redirect_to "/events"
  end

  # GET /event_reviews/1
  # GET /event_reviews/1.json
  def show
  end

  # GET /event_reviews/new
  def new
    @event_review = EventReview.new
  end

  # GET /event_reviews/1/edit
  def edit
  end

  # POST /event_reviews
  # POST /event_reviews.json
  def create
    @event_review = EventReview.new(event_review_params)

    respond_to do |format|
      if @event_review.save
        format.html { redirect_to @event_review, notice: 'Event review was successfully created.' }
        format.json { render :show, status: :created, location: @event_review }
      else
        format.html { render :new }
        format.json { render json: @event_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_reviews/1
  # PATCH/PUT /event_reviews/1.json
  def update
    respond_to do |format|
      if @event_review.update(event_review_params)
        format.html { redirect_to @event_review, notice: 'Event review was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_review }
      else
        format.html { render :edit }
        format.json { render json: @event_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_reviews/1
  # DELETE /event_reviews/1.json
  def destroy
    @event_review.destroy
    respond_to do |format|
      format.html { redirect_to event_reviews_url, notice: 'Event review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_review
      @event_review = EventReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_review_params
      params.require(:event_review).permit(:review, :user_id, :event_id)
    end
end
