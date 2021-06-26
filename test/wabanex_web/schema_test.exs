defmodule WabanexWeb.SchemaTest do
  @moduledoc false

  use WabanexWeb.ConnCase, async: true

  alias Wabanex.{Student, Students, Instructor, Instructors}

  describe "user queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{name: "José", email: "jose@gmail.com", password: "12345678"}

      {:ok, %Student{id: student_id}} = Students.Create.call(params)

      query = """
        {
          getStudent(id: "#{student_id}"){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected = %{
        "data" => %{
          "getStudent" => %{
            "email" => "jose@gmail.com",
            "id" => "#{student_id}",
            "name" => "José"
          }
        }
      }

      assert expected == response
    end

    test "when a invalid id is provided, returns an error", %{conn: conn} do
      query = """
        {
          getStudent(id: "12345678"){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 16, "line" => 2}],
            "message" => "Argument \"id\" has invalid value \"12345678\"."
          }
        ]
      }

      assert expected == response
    end

    test "when a valid id is provided but no student is found, returns an error", %{conn: conn} do
      query = """
        {
          getStudent(id: "eb61f3ef-1cc2-4aad-8fa3-d882ba4579a4"){
            id
            name
            email
          }
        }
      """

      catch_error(
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)
      )
    end
  end

  describe "user mutations" do
    test "when all params are valid, creates a student", %{conn: conn} do
      mutation = """
        mutation {
          createStudent(input: {
            name: "João",
            email: "joao@gmail.com",
            password: "12345678"
          }){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createStudent" => %{"email" => "joao@gmail.com", "name" => "João", "id" => _id}
               }
             } = response
    end

    test "when there are an invalid name, returns an error", %{conn: conn} do
      mutation = """
        mutation {
          createStudent(input: {
            name: "J",
            email: "joao@gmail.com",
            password: "12345678"
          }){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{"createStudent" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "name should be at least 2 character(s)",
                   "path" => ["createStudent"]
                 }
               ]
             } = response
    end

    test "when there are an invalid password, returns an error", %{conn: conn} do
      mutation = """
        mutation {
          createStudent(input: {
            name: "João",
            email: "joao@gmail.com",
            password: "1234567"
          }){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{"createStudent" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 5, "line" => 2}],
                   "message" => "password should be at least 8 character(s)",
                   "path" => ["createStudent"]
                 }
               ]
             } = response
    end
  end

  describe "instructor queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{cref: "12345667", name: "José", email: "jose@gmail.com", password: "12345678"}

      {:ok, %Instructor{id: instructor_id}} = Instructors.Create.call(params)

      query = """
        {
          getInstructor(id: "#{instructor_id}"){
            id
            cref
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected = %{
        "data" => %{
          "getInstructor" => %{
            "cref" => "12345667",
            "email" => "jose@gmail.com",
            "id" => instructor_id,
            "name" => "José"
          }
        }
      }

      assert expected == response
    end

    test "when valid params are given, creates an instructor and returns it", %{conn: conn} do
      mutation = """
        mutation {
          createInstructor(input: {
            name: "João",
            email: "joao@gmail.com",
            password: "12345678",
            cref: "12345667"
          }){
            id
            name
            email
            cref
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
        "data" => %{
          "createInstructor" => %{
            "cref" => "12345667",
            "email" => "joao@gmail.com",
            "id" => _id,
            "name" => "João"
          }
        }
      } = response
    end
  end
end
