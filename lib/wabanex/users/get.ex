defmodule Wabanex.Users.Get do
  @moduledoc false

  alias Ecto.UUID
  alias Wabanex.{Repo, User}

  def call(id) do
    id
    |> UUID.cast()
    |> handle_result()
  end

  defp handle_result({:ok, uuid}) do
    case Repo.get!(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp handle_result(:error), do: {:error, "Invalid Uuid"}

end
