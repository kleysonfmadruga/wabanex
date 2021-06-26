defmodule WabanexWeb.ImcControllerTest do
  @moduledoc false

  use WabanexWeb.ConnCase, async: true

  describe "calculate/2" do
    test "when all params are valid, returns the imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :calculate, params))
        |> json_response(:ok)

      expected = %{
        "result" => %{
          "Francisco" => 26.813590449954088,
          "José" => 24.691358024691358,
          "Lucas" => 24.489795918367346,
          "Maria" => 19.531249999999996,
          "Mateus" => 27.68166089965398
        }
      }

      assert expected == response
    end

    test "when there are an invalid param, returns an error", %{conn: conn} do
      params = %{"filename" => "oops.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :calculate, params))
        |> json_response(:bad_request)

      expected = %{"result" => "Oops, there's an error opening the file"}

      assert expected == response
    end
  end
end
