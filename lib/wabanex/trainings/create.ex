defmodule Wabanex.Trainings.Create do
  @moduledoc false

  alias Wabanex.{Repo, Training}

  def call(params) do
    params |> Training.changeset() |> Repo.insert()
  end
end
