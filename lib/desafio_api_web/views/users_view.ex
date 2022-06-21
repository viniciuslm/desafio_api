defmodule DesafioApiWeb.UsersView do
  use DesafioApiWeb, :view
  alias DesafioApi.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{
      message: "User created!",
      user: user,
      token: token
    }
  end

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
