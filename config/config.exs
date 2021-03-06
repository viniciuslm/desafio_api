# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :desafio_api,
  ecto_repos: [DesafioApi.Repo]

# Configures the endpoint
config :desafio_api, DesafioApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: DesafioApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: DesafioApi.PubSub,
  live_view: [signing_salt: "0RUnj1XO"]

config :desafio_api, DesafioApiWeb.Auth.Pipeline,
  module: DesafioApiWeb.Auth.Guardian,
  error_handler: DesafioApiWeb.Auth.ErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# configure Tesla
config :tesla, adapter: Tesla.Adapter.Hackney

config :desafio_api, DesafioApi.Repos.List, github_adapter: DesafioApi.Providers.GithubApi.Client

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
