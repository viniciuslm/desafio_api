defmodule DesafioApi.Repo do
  use Ecto.Repo,
    otp_app: :desafio_api,
    adapter: Ecto.Adapters.Postgres
end
