defmodule Wabanex.Instructor do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Wabanex.Student

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @fields [:cref, :name, :email, :password]

  schema "instructors" do
    field :cref, :string
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :students, Student

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_length(:cref, min: 8)
    |> unique_constraint([:email])
    |> hash_plain_password()
  end

  defp hash_plain_password(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp hash_plain_password(changeset), do: changeset
end
