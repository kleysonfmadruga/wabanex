defmodule Wabanex.Students.Get do
  @moduledoc false

  alias Ecto.UUID
  alias Wabanex.{Repo, Student}

  def call(id) do
    id
    |> UUID.cast()
    |> handle_result()
  end

  defp handle_result({:ok, uuid}) do
    case Repo.get!(Student, uuid) do
      nil -> {:error, "Student not found"}
      student -> {:ok, student}
    end
  end

  defp handle_result(:error), do: {:error, "Invalid Uuid"}

end
