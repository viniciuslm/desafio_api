defmodule DesafioApi.Repos.List do
  alias DesafioApi.Error

  def call(username) do
    case client().get_repos_user(username) do
      {:ok, repos} -> {:ok, repos}
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  defp client do
    :desafio_api
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:github_adapter)
  end
end
