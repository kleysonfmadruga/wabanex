defmodule Wabanex.Repo.Migrations.CreateTrainingsTable do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table :trainings do
      add :start_date, :date
      add :end_date, :date
      add :student_id, references(:students, type: :binary_id)

      timestamps()
    end
  end
end
