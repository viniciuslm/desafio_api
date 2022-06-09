defmodule DesafioApi.Factory do
  use ExMachina.Ecto, repo: DesafioApi.Repo

  def repos_factory do
    %{
      id: 485_035_081,
      name: "ateliware",
      html_url: "https://github.com/viniciuslm/ateliware",
      description: nil,
      stargazers_count: 0
    }
  end

  def repos_git_factory do
    %{
      "id" => 485_035_081,
      "name" => "ateliware",
      "html_url" => "https://github.com/viniciuslm/ateliware",
      "description" => nil,
      "stargazers_count" => 0
    }
  end
end
