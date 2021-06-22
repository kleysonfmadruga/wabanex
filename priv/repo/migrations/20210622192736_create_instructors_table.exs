defmodule Wabanex.Repo.Migrations.CreateInstructorsTable do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table :instructors do
      add :cref, :string
      add :email, :string
      add :password_hash, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:instructors, [:cref])
    create unique_index(:instructors, [:email])
  end
end
