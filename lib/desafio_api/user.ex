defmodule DesafioApi.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:password]

  @derive {Jason.Encoder, only: [:id]}

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def build(changeset), do: apply_action(changeset, :create)

  def changeset(params) do
    %__MODULE__{}
    |> changes(params, @required_params)
  end

  defp changes(user, params, fields) do
    user
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  def put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  def put_password_hash(changeset), do: changeset
end
