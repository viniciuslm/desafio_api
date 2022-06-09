defmodule DesafioApiWeb.Router do
  use DesafioApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DesafioApiWeb do
    pipe_through :api

    post "/repos", ReposController, :create
  end
end
