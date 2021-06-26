defmodule Wabanex.Students.Get do
  @moduledoc false

  import Ecto.Query

  alias Ecto.UUID
  alias Wabanex.{Repo, Student, Training}

  def call(id) do
    id
    |> UUID.cast()
    |> handle_result()
  end

  defp handle_result({:ok, uuid}) do
    case Repo.get!(Student, uuid) do
      nil -> {:error, "Student not found"}
      student -> {:ok, preload_data(student)}
    end
  end

  defp handle_result(:error), do: {:error, "Invalid Uuid"}

  defp preload_data(student) do
    today = Date.utc_today()

    trainings = from training in Training,
            where: ^today >= training.start_date and ^today <= training.end_date

    Repo.preload(student, :instructor)
    |> Repo.preload([trainings: {first(trainings, :inserted_at), [:exercises]}])
  end
end
