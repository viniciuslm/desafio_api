defmodule DesafioApi.Providers.GithubApi.Client do
  use Tesla

  alias DesafioApi.Error
  alias DesafioApi.Providers.GithubApi.Behaviour
  alias Tesla.Env

  @behaviour Behaviour

  @base_url "https://api.github.com/"
  plug Tesla.Middleware.JSON

  def get_repos_user(url \\ @base_url, username) do
    "#{url}users/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 400}}) do
    {:error, Error.build(:bad_request, "Limite excedido, espere mais um pouco")}
  end

  defp handle_get({:ok, %Env{status: 404}}) do
    {:error, Error.build(:not_found, "Not Found!")}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    items =
      body
      |> Enum.map(fn item ->
        %{
          "id" => id,
          "name" => name,
          "description" => description,
          "html_url" => html_url,
          "stargazers_count" => stargazers_count
        } = item

        %{
          id: id,
          name: name,
          description: description,
          html_url: html_url,
          stargazers_count: stargazers_count
        }
      end)

    {:ok, items}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
