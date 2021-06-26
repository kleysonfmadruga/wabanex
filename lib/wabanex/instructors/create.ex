defmodule Wabanex.Instructors.Create do
  @moduledoc false

  alias Wabanex.{Instructor, Repo}

  def call(params) do
    params
    |> Instructor.changeset()
    |> Repo.insert()
  end
end
