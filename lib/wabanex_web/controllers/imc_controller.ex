defmodule WabanexWeb.ImcController do
  use WabanexWeb, :controller

  alias Wabanex.Imc

  def calculate(conn, params) do
    params
    |> Imc.calculate()
    |> handle_result(conn)
  end

  defp handle_result({:ok, result}, conn) do
    %{result: result}
    |> return_response(conn, :ok)
  end

  defp hanlde_result({:error, reason}, conn) do
    %{result: reason}
    |> return_response(conn, :bad_request)
  end

  defp return_response(data, conn, status) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
