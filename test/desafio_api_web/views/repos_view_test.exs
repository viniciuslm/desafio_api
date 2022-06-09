defmodule DesafioApiWeb.ReposViewTest do
  use DesafioApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  import DesafioApi.Factory

  alias DesafioApiWeb.ReposView

  test "create.json" do
    repos = build(:repos)

    assert %{
             repos: [
               %{
                 id: 485_035_081,
                 name: "ateliware",
                 html_url: "https://github.com/viniciuslm/ateliware",
                 description: nil,
                 stargazers_count: 0
               }
             ]
           } = render(ReposView, "create.json", repos: [repos])
  end
end
