defmodule WabanexWeb.Schema.Types.Instructor do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "Logic instructor representation"
  object :instructor do
    field :id, non_null(:uuid4), description: "Instructor's id"
    field :cref, non_null(:string), description: "Instructor's Regional Council of Physical Education number"
    field :name, non_null(:string), description: "Instructor's name"
    field :email, non_null(:string), description: "Instructor's email"
    field :students, list_of(:student), description: "Instructor's students"
  end

  input_object :create_instructor_input do
    field :cref, non_null(:string), description: "Instructor's Regional Council of Physical Education number"
    field :name, non_null(:string), description: "Instructor's name"
    field :email, non_null(:string), description: "Instructor's email"
    field :password, non_null(:string), description: "Instructor's password"
  end
end
