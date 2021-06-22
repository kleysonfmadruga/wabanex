defmodule Wabanex.Students.Create do
  @moduledoc false

  alias Wabanex.{Repo, Student}

  def call(params) do
    params
    |> Student.changeset()
    |> Repo.insert()
  end
end
