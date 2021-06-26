defmodule Wabanex.Instructors.Get do
  @moduledoc false

  alias Ecto.UUID
  alias Wabanex.{Instructor, Repo}

  def call(instructor_id) do
    instructor_id
    |> UUID.cast()
    |> handle_result()
  end

  defp handle_result({:ok, uuid}) do
    case Repo.get(Instructor, uuid) |> Repo.preload(:students) do
      nil -> {:error, "Instructor not found"}
      instructor -> {:ok, instructor}
    end
  end

  defp handle_result(:error), do: {:error, "Invalid Uuid"}
end
