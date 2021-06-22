defmodule Wabanex.Class do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias Wabanex.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @fields [:name]

  schema "classes" do
    field :name, :string
    has_many :users, User

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:name, min: 2)
  end
end
