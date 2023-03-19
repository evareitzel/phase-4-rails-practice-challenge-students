class StudentsController < ApplicationController
  # add rescue_from
  # Make sure to handle errors and invalid data by returning the appropriate status code along with a message.

  # GET /students
  def index
    students = Student.all
    render json: students
  end
  
  # GET /students/:id
  def show
    student = Student.find(params[:id])
    render json: student
    # needs error message (status: :not_found)
  end

# POST /students
  def create
    student = Student.create(student_params)
    render json: student, status: :created
    # needs error message - (? status: 	:unprocessable_entity)
  end

  # PATCH /students/:id
  def update
    student = Student.find(params[:id])
    student.update(student_params)
    render json: student
    # needs error message
  end

  # DELETE /students/:id
  def destroy
    student = Student.find(params[:id])
    student.destroy # attn - no need to destroy dependent collections first (?)
    render json: {} # status code?
    # needs error message
  end

  private

  # student_params
  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end

  # AR rescue method
end
