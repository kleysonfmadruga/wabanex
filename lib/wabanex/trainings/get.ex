defmodule Wabanex.Trainings.Get do
  @moduledoc false

  alias Ecto.UUID
  alias Wabanex.{Repo, Training}

  def call(training_id) do
    training_id
    |> UUID.cast()
    |> handle_result()
  end

  defp handle_result({:ok, uuid}) do
    case Repo.get(Training, uuid) |> Repo.preload(:exercises) do
      nil -> {:error, "Training not found"}
      training -> {:ok, training}
    end
  end

  defp handle_result(:error), do: {:error, "Invalid Uuid"}
end
