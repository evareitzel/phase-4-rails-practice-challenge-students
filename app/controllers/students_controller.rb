class StudentsController < ApplicationController
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
 
  # GET /students
  def index
    students = Student.all
    render json: students, status: :accepted
  end
  
  # GET /students/:id
  def show
    student = find_student
      render json: student, status: :accepted
    # rescue_from :render_not_found_response
  end

# POST /students
  def create
    student = Student.create(student_params)
    if student.valid?
      render json: student, status: :created
    else
      render json: { error: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /students/:id
  def update
    student = find_student
    student.update(student_params)
    if student.valid?
      render json: student
    else
      render json: { error: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /students/:id
  def destroy
    student = find_student
    student.destroy
    render json: {}
    # rescue_from :render_not_found_response
  end


  private

  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end

  def find_student
    Student.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Student not found" }, status: :not_found
  end

end
