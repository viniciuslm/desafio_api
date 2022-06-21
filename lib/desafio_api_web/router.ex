defmodule DesafioApiWeb.Router do
  use DesafioApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DesafioApiWeb do
    pipe_through :api

    post "/repos", ReposController, :create
    post "/users/", UsersController, :create
    post "/users/signin", UsersController, :sign_in
  end
end
