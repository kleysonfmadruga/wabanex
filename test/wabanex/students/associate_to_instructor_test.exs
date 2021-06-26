defmodule Wabanex.Students.AssociateToInstructorTest do
  @moduledoc false

  use Wabanex.DataCase, async: true

  alias Wabanex.{Instructors, Students}

  describe "call/1" do
    test "when valid and existing student id and instructor id are given, associate them" do
      student_params = %{name: "José", email: "jose@gmail.com", password: "12345678"}

      instructor_params = %{
        cref: "12345667",
        name: "Maria",
        email: "maria@gmail.com",
        password: "12345678"
      }

      {:ok, %{id: student_id}} = Students.Create.call(student_params)
      {:ok, %{id: instructor_id}} = Instructors.Create.call(instructor_params)

      response =
        Students.AssociateToInstructor.call(%{
          student_id: student_id,
          instructor_id: instructor_id
        })

      assert {:ok,
              %Wabanex.Student{
                email: "jose@gmail.com",
                id: _id,
                instructor: %Wabanex.Instructor{
                  cref: "12345667",
                  email: "maria@gmail.com",
                  id: instructor_id,
                  name: "Maria"
                },
                instructor_id: instructor_id,
                name: "José"
              }} = response
    end
  end
end
