class InstructorsController < ApplicationController
  # add rescue_from
    # Make sure to handle errors and invalid data by returning the appropriate status code along with a message.

  def index
    instructors = Instructor.all
    render json: instructors
  end

  # GET /instructors/:id
  def show
    instructor = Instructor.find(params[:id])
    render json: instructor
    # needs error message (status: :not_found)
  end

  # POST /instructors
  def create
    instructor = Instructor.create(instructor_params)
    render json: instructor, status: :created
    # needs error message - (? status: 	:unprocessable_entity)
  end

  # PATCH /instructors/:id
  def update
    instructor = Instructor.find(params[:id])
    instructor.update(instructor_params)
    render json: instructor
    # needs error message
  end

  # DELETE /instructors/:id
  def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy # attn - no need to destroy dependent collections first (?)
    render json: {} # status code?
    # needs error message
  end

  private

  def instructor_params
    params.permit(:name)
  end

  # AR rescue method

end
