ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(DesafioApi.Repo, :manual)

Mox.defmock(DesafioApi.Providers.GithubApi.ClientMock,
  for: DesafioApi.Providers.GithubApi.Behaviour
)
