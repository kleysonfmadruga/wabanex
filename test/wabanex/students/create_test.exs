defmodule Wabanex.Students.CreateTest do
  @moduledoc false

  use Wabanex.DataCase, async: true
  alias Wabanex.Students.Create
  alias Wabanex.Student

  describe "call/1" do
    test "when all params are valid, creates a student and returns it" do
      params = %{name: "José", email: "jose@gmail.com", password: "12345678"}

      response = Create.call(params)

      assert {:ok,
              %Student{
                name: "José",
                email: "jose@gmail.com",
                password: "12345678",
                password_hash: _hash
              }
            } = response
    end

    test "when the email is invalid, returns an error" do
      params = %{name: "José", email: "josegmail.com", password: "12345678"}

      response = Create.call(params)

      assert {:error,
              %Ecto.Changeset{
                changes: %{email: "josegmail.com", name: "José", password: "12345678"},
                errors: [email: {"has invalid format", [validation: :format]}],
                valid?: false
              }
            } = response
    end

    test "when the name is too sm, returns an error" do
      params = %{name: "J", email: "jose@gmail.com", password: "12345678"}

      response = Create.call(params)

      assert {:error,
              %Ecto.Changeset{
                changes: %{email: "jose@gmail.com", name: "J", password: "12345678"},
                errors: [
                  name: {"should be at least %{count} character(s)",
                  [count: 2, validation: :length, kind: :min, type: :string]}
                ],
                valid?: false
              }
            } = response
    end
  end
end
