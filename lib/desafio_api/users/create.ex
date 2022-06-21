defmodule DesafioApi.Users.Create do
  alias DesafioApi.{Error, Repo, User}

  def call(params) do
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, %User{}} = user <- create_user(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  defp create_user(changeset) do
    Repo.insert(changeset)
  end
end
