class InstructorsController < ApplicationController
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /instructors
  def index
    instructors = Instructor.all
    render json: instructors
  end

  # GET /instructors/:id
  def show
    instructor = find_instructor
    render json: instructor
    # rescue_from :render_not_found_response
  end

  # POST /instructors
  def create
    instructor = Instructor.create(instructor_params)
    if instructor.valid?
      render json: instructor, status: :created
    else
      render json: { error: instructor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /instructors/:id
  def update
    instructor = find_instructor
    instructor.update(instructor_params)
    if instructor.valid?
      render json: instructor, status: :accepted
    else
      render json: { error: instructor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /instructors/:id
  def destroy
    instructor = find_instructor
    instructor.destroy
    render json: {}
    # rescue_from :render_not_found_response
  end


  private

  def instructor_params
    params.permit(:name)
  end

  def find_instructor
    Instructor.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Instructor not found" }, status: :not_found
  end

end
