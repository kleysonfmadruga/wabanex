defmodule Wabanex.ImcTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Wabanex.Imc

  describe "calculate/1" do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = Imc.calculate(params)

      expected =
        {:ok,
         %{
           "Francisco" => 26.813590449954088,
           "José" => 24.691358024691358,
           "Lucas" => 24.489795918367346,
           "Maria" => 19.531249999999996,
           "Mateus" => 27.68166089965398
         }}

      assert expected == response
    end

    test "when the file don't exists, returns an error" do
      params = %{"filename" => "theres_an_error.csv"}

      response = Imc.calculate(params)

      expected = {:error, "Oops, there's an error opening the file"}

      assert expected == response
    end
  end
end
