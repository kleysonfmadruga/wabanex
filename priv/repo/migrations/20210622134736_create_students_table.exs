defmodule Wabanex.Repo.Migrations.CreateStudentsTable do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table :students do
      add :name, :string
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:students, [:email])
  end
end
