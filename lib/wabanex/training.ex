defmodule Wabanex.Training do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias Wabanex.{Exercise, Student}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @fields [:start_date, :end_date, :student_id]

  schema "trainings" do
    field :start_date, :date
    field :end_date, :date

    belongs_to :student, Student
    has_many :exercises, Exercise

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> cast_assoc(:exercises)
  end
end
