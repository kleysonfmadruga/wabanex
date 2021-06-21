defmodule Wabanex.Imc do
  def calculate(%{"filename" => filename}) do
    filename
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, result}) do
    calculated_imc = result
    |> String.split("\n")
    |> Enum.map(fn line -> handle_line(line) end)
    |> Enum.into(%{})

    {:ok, calculated_imc}
  end

  defp handle_file({:error, _reason}) do
    {:error, "Oops, there's an error opening the file"}
  end

  defp handle_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, fn strNumber -> String.to_float(strNumber) end)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
