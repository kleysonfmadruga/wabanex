defmodule WabanexWeb.Schema.Types.Student do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Logic student representation"
  object :student do
    field :id, non_null(:uuid4), description: "Student's id"
    field :name, non_null(:string), description: "Student's name"
    field :email, non_null(:string), description: "Student's email"
    field :trainings, list_of(:training), description: "Student's trainings"
    field :instructor, :instructor, description: "Student's instructor"
  end

  input_object :create_student_input do
    field :name, non_null(:string), description: "Student's name"
    field :email, non_null(:string), description: "Student's email"
    field :password, non_null(:string), description: "Student's password"
  end

  @desc "Logic association of student and instructor"
  input_object :create_association_to_instructor do
    field :student_id, non_null(:uuid4), description: "Student's id"
    field :instructor_id, non_null(:uuid4), description: "Instructor's id"
  end
end
