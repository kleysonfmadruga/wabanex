defmodule Wabanex.StudentTest do
  @moduledoc false

  use Wabanex.DataCase, async: true

  alias Wabanex.Student

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "José", email: "jose@gmail.com", password: "12345678"}

      response = Student.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        errors: [],
        changes: %{name: "José", email: "jose@gmail.com", password: "12345678", password_hash: _password_hash}
      } = response
    end

    test "when email address is invalid, returns an error" do
      params = %{name: "José", email: "josegmail.com", password: "12345678"}

      response = Student.changeset(params)

      assert errors_on(response) == %{email: ["has invalid format"]}
    end

    test "when the name is too short, returns an error" do
      params = %{name: "J", email: "jose@gmail.com", password: "12345678"}

      response = Student.changeset(params)

      assert errors_on(response) == %{name: ["should be at least 2 character(s)"]}
    end

    test "when the password is too short, returns an error" do
      params = %{name: "José", email: "jose@gmail.com", password: "1234567"}

      response = Student.changeset(params)

      assert errors_on(response) == %{password: ["should be at least 8 character(s)"]}
    end
  end
end
