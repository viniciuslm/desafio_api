defmodule DesafioApiWeb.ReposView do
  use DesafioApiWeb, :view

  def render("create.json", %{repos: repos}), do: %{repos: repos}
end
