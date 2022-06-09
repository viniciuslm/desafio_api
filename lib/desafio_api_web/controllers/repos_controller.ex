defmodule DesafioApiWeb.ReposController do
  use DesafioApiWeb, :controller

  alias DesafioApi.Repos.List
  alias DesafioApiWeb.ErrorView
  alias DesafioApiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, %{"username" => username}) do
    with {:ok, repos} <- List.call(username) do
      conn
      |> put_status(:ok)
      |> render("create.json", repos: repos)
    end
  end

  def create(conn, _) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", result: "Informe o username")
  end
end
