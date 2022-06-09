defmodule DesafioApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DesafioApi.Repo,
      # Start the Telemetry supervisor
      DesafioApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DesafioApi.PubSub},
      # Start the Endpoint (http/https)
      DesafioApiWeb.Endpoint
      # Start a worker by calling: DesafioApi.Worker.start_link(arg)
      # {DesafioApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DesafioApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DesafioApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
