defmodule Wabanex.User do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset
  alias Ecto.Changeset

#  alias Wabanex.Class

  @primary_key {:id, :binary_id, autogenerate: true}
  @fields [:name, :email, :password]

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    #belongs_to :class, Class

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> unique_constraint([:email])
    |> hash_plain_password()
  end

  defp hash_plain_password(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp hash_plain_password(changeset), do: changeset
end
