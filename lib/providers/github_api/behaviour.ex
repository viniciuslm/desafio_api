defmodule DesafioApi.Providers.GithubApi.Behaviour do
  alias DesafioApi.Error

  @callback get_repos_user(String.t()) :: {:ok, map} | {:error, Error.t()}
end
