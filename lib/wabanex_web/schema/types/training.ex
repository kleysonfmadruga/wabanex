defmodule WabanexWeb.Schema.Types.Training do
  @moduledoc false

  use Absinthe.Schema.Notation

  import_types WabanexWeb.Schema.Types.Exercise

  @desc "Logic training representation"
  object :training do
    field :id, non_null(:uuid4), description: "Training's id"
    field :start_date, non_null(:string), description: "Training's start date"
    field :end_date, non_null(:string), description: "Training's end date"
    field :exercises, list_of(:exercise), description: "Training's list of exercises"
  end

  input_object :create_training_input do
    field :student_id, non_null(:uuid4), description: "Training's student id"
    field :start_date, non_null(:string), description: "Training's start date"
    field :end_date, non_null(:string), description: "Training's end date"
    field :exercises, list_of(:create_exercise_input), description: "Training's list of exercises"
  end
end
