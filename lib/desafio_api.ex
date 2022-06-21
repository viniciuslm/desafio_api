defmodule DesafioApi do
  @moduledoc """
  DesafioApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias DesafioApi.Users.Create, as: UserCreate
  alias DesafioApi.Users.Get, as: UserGet

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user(id), to: UserGet, as: :by_id
end
