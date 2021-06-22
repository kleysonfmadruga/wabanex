defmodule Wabanex.Repo.Migrations.AddClassToStudentsTable do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table :students do
      add :instructor_id, references(:instructors, type: :binary_id)
    end
  end
end
