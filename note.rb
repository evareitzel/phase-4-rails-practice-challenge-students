 # Make sure to handle errors and invalid data by returning the appropriate status code along with a message.

# TEST EVERYTHING - actions & error/status
# REVIEW solution code


# "Invalid input parameters"
# "Name can't be blank"
# "Name must be present"

## instructors_controller.rb - DRAFT 1

class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  rescue_from ActiveRecord::RecordNotSaved, with: :render_not_saved_response

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
    # error message & status code not working
  end

  # PATCH /instructors/:id
  def update
    instructor = find_instructor
    instructor.update(instructor_params)
    render json: instructor
    # error message & status code not wkg
  end

  # DELETE /instructors/:id
  def destroy
    instructor = find_instructor
    instructor.destroy
    render json: {}
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

  def render_not_saved_response
    render json: { error: "Name can't be blank"}, status: :unprocessable_entity
  end

end


## students_controller.rb DRAFT 1

class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
 
  rescue_from ActiveRecord::RecordNotSaved, with: :render_not_saved_response

  # GET /students
  def index
    students = Student.all
    render json: students
  end
  
  # GET /students/:id
  def show
    student = find_student
    render json: student
  end

# POST /students
  def create
    student = Student.create(student_params)
    render json: student, status: :created
    # error message & status code not working
    # must be associated w instructor (CREATE/UPDATE)
  end

  # PATCH /students/:id
  def update
    student = find_student
    student.update(student_params)
    render json: student
    # error message & status code not working
    # must be associated w instructor (CREATE/UPDATE)
  end

  # DELETE /students/:id
  def destroy
    student = find_student
    student.destroy
    render json: {}
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

  def render_not_saved_response
    render json: { error: "Name must be present"}, status: :unprocessable_entity
  end

end

