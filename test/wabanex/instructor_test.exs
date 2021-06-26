defmodule Wabanex.InstructorTest do
  @moduledoc false

  use Wabanex.DataCase, async: true

  alias Wabanex.Instructor

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{cref: "12345667", name: "José", email: "jose@gmail.com", password: "12345678"}

      response = Instructor.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               errors: [],
               changes: %{
                 cref: "12345667",
                 name: "José",
                 email: "jose@gmail.com",
                 password: "12345678",
                 password_hash: _hash
               }
             } = response
    end

    test "when the CREF is blank, returns an error" do
      params = %{cref: "", name: "José", email: "jose@gmail.com", password: "12345678"}

      response = Instructor.changeset(params)

      assert %Ecto.Changeset{
               valid?: false,
               errors: [{:cref, {"can't be blank", [validation: :required]}}],
               changes: %{
                 name: "José",
                 email: "jose@gmail.com",
                 password: "12345678"
               }
             } = response
    end

    test "when the name is too short, returns an error" do
      params = %{cref: "12345667", name: "J", email: "jose@gmail.com", password: "12345678"}

      response = Instructor.changeset(params)

      assert %Ecto.Changeset{
               valid?: false,
               errors: [name: {"should be at least %{count} character(s)", [count: 2, validation: :length, kind: :min, type: :string]}],
               changes: %{
                 cref: "12345667",
                 email: "jose@gmail.com",
                 password: "12345678"
               }
             } = response
    end

    test "when the email is invalid, returns an error" do
      params = %{cref: "12345667", name: "João", email: "josegmail.com", password: "12345678"}

      response = Instructor.changeset(params)

      assert %Ecto.Changeset{
               valid?: false,
               errors: [email: {"has invalid format", [validation: :format]}],
               changes: %{
                 cref: "12345667",
                 name: "João",
                 password: "12345678"
               }
             } = response
    end
  end
end
