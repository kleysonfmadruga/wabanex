defmodule WabanexWeb.Schema.Types.Root do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias WabanexWeb.Resolvers
  alias Crudry.Middlewares.TranslateErrors

  alias WabanexWeb.Schema.Types

  import_types Types.Student
  import_types Types.Training
  import_types Types.Instructor
  import_types Types.Custom.UUID4

  object :root_query do
    field :get_student, type: :student, description: "Get student query" do
      arg :id, non_null(:uuid4)

      resolve &Resolvers.Student.get/2
    end

    field :get_training, type: :training, description: "Get training query" do
      arg :id, non_null(:uuid4)

      resolve &Resolvers.Training.get/2
    end

    field :get_instructor, type: :instructor, description: "Get instructor query" do
      arg :id, non_null(:uuid4)

      resolve &Resolvers.Instructor.get/2
    end
  end

  object :root_mutation do
    field :create_student, type: :student, description: "Create student mutation" do
      arg :input, non_null(:create_student_input)

      resolve &Resolvers.Student.create/2
      middleware TranslateErrors
    end

    field :create_training, type: :training, description: "Create training mutation" do
      arg :input, non_null(:create_training_input)

      resolve &Resolvers.Training.create/2
      middleware TranslateErrors
    end

    field :create_instructor, type: :instructor, description: "Create instructor mutation" do
      arg :input, non_null(:create_instructor_input)

      resolve &Resolvers.Instructor.create/2
      middleware TranslateErrors
    end

    field :associate_to_instructor, type: :student, description: "Associate instructor to student mutation" do
      arg :input, non_null(:create_association_to_instructor)

      resolve &Resolvers.Student.associate_to_instructor/2
      middleware TranslateErrors
    end
  end
end
