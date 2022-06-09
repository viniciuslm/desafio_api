import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :desafio_api, DesafioApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "desafio_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :desafio_api, DesafioApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "q6R3JiNoX+9OVpLN8UnxkPGZq8ubTOrFiDdE/37hbRRaXYzhMX+BfAZZhaxa8bL9",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :desafio_api, DesafioApi.Repos.List,
  github_adapter: DesafioApi.Providers.GithubApi.ClientMock
