defmodule DesafioApiWeb.FallbackController do
  use DesafioApiWeb, :controller

  alias DesafioApi.Error
  alias DesafioApiWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
