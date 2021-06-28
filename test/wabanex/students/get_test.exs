defmodule Wabanex.Students.GetTest do
  @moduledoc false

  use Wabanex.DataCase, async: true

  alias Wabanex.Students.{Create, Get}

  describe "call/1" do
    test "when a valid id is given, return a student" do
      student_params = %{name: "José", email: "jose@gmail.com", password: "12345678"}

      {:ok, %{id: student_id}} = student_params |> Create.call()

      student = student_id |> Get.call()

      assert {:ok,
              %Wabanex.Student{
                email: "jose@gmail.com",
                id: _id,
                instructor_id: nil,
                name: "José",
                password: nil,
                password_hash: _hash
              }
            } = student
    end
  end
end
