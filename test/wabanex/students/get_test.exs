defmodule Wabanex.Students.GetTest do
  @moduledoc false

  use Wabanex.DataCase, async: true

  alias Wabanex.Students.{Create, Get}

  describe "call/1" do
    test "when a valid id is given, return a student" do
      student_params = %{name: "José", email: "jose@gmail.com", password: "12345678"}

      {:ok, %{id: student_id}} = student_params |> Create.call()

      response = student_id |> Get.call()

      assert {:ok,
              %Wabanex.Student{
                email: "jose@gmail.com",
                id: _id,
                instructor_id: nil,
                name: "José",
                password: nil,
                password_hash: _hash
              }
            } = response
    end

    test "when an invalid id is given, return an error" do
      response = "2578458736583" |> Get.call()

      assert {:error, "Invalid Uuid"} = response
    end

    test "when a valid but non-existent id is given, returns an error" do
      assert_raise(
        Ecto.NoResultsError,
        fn ->
          "57d34753-6cce-4e93-9a4a-b21727486539" |> Get.call()
        end
      )
    end
  end
end
