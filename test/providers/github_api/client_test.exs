defmodule DesafioApi.Providers.GithubApi.ClientTest do
  use ExUnit.Case, async: true

  import DesafioApi.Factory

  alias Plug.Conn

  alias DesafioApi.Error
  alias DesafioApi.Providers.GithubApi.Client

  describe "get_repos_user/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "When there is a valid username, returns repos", %{bypass: bypass} do
      username = "viniciuslm"

      url = endpoint_url(bypass.port)

      body = ~s([
        {
          "id": 485035081,
          "name": "ateliware",
          "html_url": "https://github.com/viniciuslm/ateliware",
          "description": null,
          "stargazers_count": 0
        }
      ])

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_repos_user(url, username)

      expected_response = {:ok, [build(:repos)]}

      assert response == expected_response
    end

    test "When except limit, returns an error", %{bypass: bypass} do
      username = "viniciuslm"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.resp(400, "")
      end)

      response = Client.get_repos_user(url, username)

      expected_response =
        {:error, Error.build(:bad_request, "Limite excedido, espere mais um pouco")}

      assert response == expected_response
    end

    test "When the usernqme was not found, returns an error", %{bypass: bypass} do
      username = "viniciuslm"

      body = ~s({
        "message": "Not Found",
        "documentation_url": "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user"
      })

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, body)
      end)

      response = Client.get_repos_user(url, username)

      expected_response = {:error, Error.build(:not_found, "Not Found!")}

      assert response == expected_response
    end

    test "When there is a generic error, return an error", %{bypass: bypass} do
      username = "viniciuslm"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_repos_user(url, username)

      {:error, %Error{status: :bad_request}} = response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
