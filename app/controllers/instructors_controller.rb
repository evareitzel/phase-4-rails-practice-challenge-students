class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
    # GET /instructors
    def index
      instructors = Instructor.all
      render json: instructors
    end
  
    # GET /instructors/:id
    def show
      instructor = find_instructor
      render json: instructor
    end
  
    # POST /instructors
    def create
      instructor = Instructor.create!(instructor_params)
      render json: instructor, status: :created
    end
  
    # PATCH /instructors/:id
    def update
      instructor = find_instructor
      instructor.update!(instructor_params)
      render json: instructor
    end
  
    # DELETE /instructors/:id
    def destroy
      instructor = find_instructor
      instructor.destroy
      head :no_content
    end
    
    private
  
    def find_instructor
      Instructor.find(params[:id])
    end
  
    def instructor_params
      params.permit(:name)
    end
  
    def render_not_found_response
      render json: { errors: ["Instructor not found"] }, status: :not_found
    end
  
    def render_unprocessable_entity_response(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
  
  end
  